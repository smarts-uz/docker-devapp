import { Client as PgClient, Pool } from "pg";
import { Client as OSClient } from "@opensearch-project/opensearch";
import fs from "fs";

/* =========================
   CONFIG
========================= */

const TABLES_TO_SYNC = (process.env.TABLES_TO_SYNC || "")
  .split(",")
  .map(t => t.trim())
  .filter(Boolean);

const LISTEN_CHANNEL =
  process.env.PG_LISTEN_CHANNEL || "table_changes";

const LAST_SYNC_FILE = "./lastSyncTimes.json";

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
      const payload = JSON.parse(msg.payload);
      const table = payload.table;

      if (!TABLES_TO_SYNC.includes(table)) return;

      console.log(`📣 Change detected → ${table}`);
      await incrementalSync(table);
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

async function ensureIndexes(tables) {
  for (const table of tables) {
    await osClient.indices.create(
      {
        index: table,
        body: {
          mappings: {
            dynamic: true,
            properties: {
              id_str: { type: "keyword" },
            },
          },
        },
      },
      { ignore: [400] }
    );
  }
}

async function fullSync(tables) {
  for (const table of tables) {
    console.log(`🔄 Full sync → ${table}`);

    const { rows } = await pgPool.query(
      `SELECT * FROM "${table}" WHERE deleted_at IS NULL`
    );

    await indexRows(table, rows);
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

  await indexRows(table, updated);

  const { rows: deleted } = await pgPool.query(
    `SELECT id FROM "${table}"
     WHERE deleted_at IS NOT NULL
       AND deleted_at > $1`,
    [since]
  );

  for (const row of deleted) {
    await osClient
      .delete({
        index: table,
        id: row.id,
      })
      .catch(() => {});
  }

  lastSyncTimes[table] = new Date();
  saveLastSyncTimes(lastSyncTimes);
}

/* =========================
   INDEXING
========================= */

async function indexRows(table, rows) {
  if (!rows.length) return;

  for (const row of rows) {
    const body = normalizeRow(row);
    body.id_str = String(row.id);

    await osClient.index({
      index: table,
      id: row.id,
      body,
    });
  }

  console.log(`✅ ${rows.length} rows indexed → ${table}`);
}

/* =========================
   NORMALIZATION
   (ignore object / json columns)
========================= */

function normalizeRow(row) {
  const result = {};

  for (const [key, value] of Object.entries(row)) {
    if (
      value === null ||
      value === undefined ||
      typeof value === "object"
    ) {
      continue;
    }

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
    Object.keys(parsed).forEach(
      k => (parsed[k] = new Date(parsed[k]))
    );
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
