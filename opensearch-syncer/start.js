import { Client as PgClient, Pool } from "pg";
import { Client as OSClient } from "@opensearch-project/opensearch";
import fs from "fs";

/* =========================
   CONFIG
========================= */

const TABLES_TO_SYNC = (process.env.TABLES_TO_SYNC || "")
  .split(",")
  .map((t) => t.trim())
  .filter(Boolean);

const LISTEN_CHANNEL = "table_changes";
const LAST_SYNC_FILE = "./lastSyncTimes.json";
const BULK_SIZE = 500;

/* =========================
   CLIENTS
========================= */

const pgPool = new Pool({
  user: process.env.PG_USER,
  host: process.env.PG_HOST,
  database: process.env.PG_DATABASE,
  password: process.env.PG_PASSWORD,
  port: process.env.PG_PORT,
});

const osClient = new OSClient({
  node: process.env.OPENSEARCH_NODE || "http://localhost:9200",
});

/* =========================
   STATE
========================= */

let lastSyncTimes = loadLastSyncTimes();
const syncInProgress = new Set();
const pendingSync = new Set();

/* =========================
   ENTRY
========================= */

async function main() {
  console.log("🚀 Syncer starting");

  await ensureIndexes(TABLES_TO_SYNC);

  console.log("📦 Running initial full sync...");
  await fullSync(TABLES_TO_SYNC);
  console.log("✅ Initial sync completed");

  const listener = new PgClient(pgPool.options);
  await listener.connect();

  await listener.query(`LISTEN ${LISTEN_CHANNEL}`);
  console.log(`👂 Listening on channel: ${LISTEN_CHANNEL}`);

  listener.on("notification", async (msg) => {
    try {
      console.log("📩 Notification received:", {
        channel: msg.channel,
        payload: msg.payload,
        payloadLength: msg.payload?.length,
      });
      // Validate payload before parsing
      if (!msg.payload || msg.payload.trim() === "") {
        console.warn("⚠️ Empty notification payload received");
        return;
      }

      let payload;
      try {
        payload = JSON.parse(msg.payload);
      } catch (parseErr) {
        console.error(
          "❌ Invalid JSON payload:",
          msg.payload?.substring(0, 200)
        );
        return;
      }

      const table = payload?.table;

      if (!table || !TABLES_TO_SYNC.includes(table)) return;

      // Debounce: if sync in progress, queue it
      if (syncInProgress.has(table)) {
        pendingSync.add(table);
        return;
      }

      await runIncrementalSync(table);
    } catch (err) {
      console.error("❌ Notification error:", err);
    }
  });

  process.on("SIGINT", async () => {
    console.log("🛑 Shutting down");
    await listener.end();
    await pgPool.end();
    process.exit(0);
  });
}

main().catch(console.error);

/* =========================
   SYNC LOGIC
========================= */

async function runIncrementalSync(table) {
  syncInProgress.add(table);

  try {
    await incrementalSync(table);
  } finally {
    syncInProgress.delete(table);

    // Process pending if queued during sync
    if (pendingSync.has(table)) {
      pendingSync.delete(table);
      setImmediate(() => runIncrementalSync(table));
    }
  }
}

async function ensureIndexes(tables) {
  for (const table of tables) {
    const exists = await osClient.indices.exists({ index: table });
    if (exists.body) continue;

    await osClient.indices.create({
      index: table,
      body: {
        settings: {
          analysis: {
            analyzer: {
              translit_analyzer: {
                tokenizer: "standard",
                filter: ["lowercase", "russian_translit"],
              },
            },
            filter: {
              russian_translit: {
                type: "icu_transform",
                id: "Any-Latin; Latin-Cyrillic",
              },
            },
          },
        },
        mappings: {
          dynamic: true,
          properties: {
            id_str: { type: "keyword" },
            name: {
              type: "text",
              analyzer: "translit_analyzer",
              search_analyzer: "translit_analyzer",
            },
          },
        },
      },
    });

    console.log(`📁 Index created: ${table}`);
  }
}

async function fullSync(tables) {
  for (const table of tables) {
    console.log(`🔄 Full sync → ${table}`);

    const { rows } = await pgPool.query(
      `SELECT * FROM "${table}" WHERE deleted_at IS NULL`
    );

    await bulkIndex(table, rows);
    lastSyncTimes[table] = new Date();
  }

  saveLastSyncTimes(lastSyncTimes);
}

async function incrementalSync(table) {
  console.log(`🔁 Incremental sync → ${table}`);

  const since = lastSyncTimes[table] || new Date(0);

  const { rows: updated } = await pgPool.query(
    `SELECT * FROM "${table}"
     WHERE updated_at > $1 AND deleted_at IS NULL`,
    [since]
  );

  if (updated.length) {
    await bulkIndex(table, updated);
  }

  const { rows: deleted } = await pgPool.query(
    `SELECT id FROM "${table}"
     WHERE deleted_at IS NOT NULL AND deleted_at > $1`,
    [since]
  );

  if (deleted.length) {
    await bulkDelete(
      table,
      deleted.map((r) => r.id)
    );
  }

  lastSyncTimes[table] = new Date();
  saveLastSyncTimes(lastSyncTimes);
}

/* =========================
   BULK OPERATIONS
========================= */

async function bulkIndex(table, rows) {
  if (!rows.length) return;

  for (let i = 0; i < rows.length; i += BULK_SIZE) {
    const chunk = rows.slice(i, i + BULK_SIZE);
    const body = [];

    for (const row of chunk) {
      const doc = normalizeRow(row);
      doc.id_str = String(row.id);

      body.push({ index: { _index: table, _id: row.id } });
      body.push(doc);
    }

    const { body: result } = await osClient.bulk({ body, refresh: false });

    if (result.errors) {
      const errors = result.items.filter((item) => item.index?.error);
      console.error(`⚠️ Bulk errors:`, errors.slice(0, 3));
    }
  }

  await osClient.indices.refresh({ index: table });
  console.log(`✅ ${rows.length} rows indexed → ${table}`);
}

async function bulkDelete(table, ids) {
  if (!ids.length) return;

  const body = ids.map((id) => ({
    delete: { _index: table, _id: id },
  }));

  await osClient.bulk({ body, refresh: true });
  console.log(`🗑️ ${ids.length} rows deleted → ${table}`);
}

/* =========================
   NORMALIZATION
========================= */

function normalizeRow(row) {
  const result = {};

  for (const [key, value] of Object.entries(row)) {
    if (value === null || value === undefined) continue;

    // Keep Date objects (convert to ISO string)
    if (value instanceof Date) {
      result[key] = value.toISOString();
      continue;
    }

    // Skip other objects (JSON columns)
    if (typeof value === "object") continue;

    if (typeof value === "string") {
      const v = value.trim().toLowerCase();
      if (v === "" || v === "null" || v === "undefined") continue;
    }

    result[key] = value;
  }

  return result;
}

/* =========================
   SYNC STATE
========================= */

function loadLastSyncTimes() {
  try {
    const raw = fs.readFileSync(LAST_SYNC_FILE, "utf8");
    const parsed = JSON.parse(raw);
    Object.keys(parsed).forEach((k) => (parsed[k] = new Date(parsed[k])));
    return parsed;
  } catch {
    return {};
  }
}

function saveLastSyncTimes(times) {
  const out = {};
  for (const k of Object.keys(times)) {
    out[k] = times[k].toISOString();
  }
  fs.writeFileSync(LAST_SYNC_FILE, JSON.stringify(out, null, 2));
}
