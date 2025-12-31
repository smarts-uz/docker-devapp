# PostgREST security (dev)

This repo runs PostgREST behind Nginx and enforces database-level permissions (RLS).

## Entry points

- Recommended (via Nginx): `http://localhost/` (see `docker-compose.dev.yml`)
- Direct (debug only): `http://localhost:${PGRST_PORT_DEV:-9000}/` (bypasses Nginx protections)

## Controls implemented

- **Rate limiting (Nginx)**: `nginx/configs/pgrest.conf`
  - `limit_req_zone ... rate=5r/s` with `burst=10 nodelay`
- **Block `Prefer: count=exact` (Nginx)**: `nginx/configs/pgrest.conf`
  - Requests containing `Prefer: count=exact` return **400** (`Exact counts are not allowed`)
- **Prefer estimated counts (Postgres roles)**: `postgres/init.sql`, `postgres/rls.sql`
  - `ALTER ROLE ... SET pgrst.count = 'estimated'` for `anon`, `web_anon`, `authenticated`
- **Row Level Security (RLS)**: `postgres/rls.sql`
  - Creates `authenticated` role (if missing)
  - `auth_user_id()` reads `request.jwt.claims` and policies restrict rows per `user_id`

## Quick checks

> Use `curl.exe` on Windows PowerShell.

- Block exact count:
  - `curl.exe -i -H "Prefer: count=exact" http://localhost/tour_team`
- Allow estimated count:
  - `curl.exe -I -H "Prefer: count=estimated" http://localhost/tour_team`

## Where to change things

- Nginx protections (rate limit / headers): `nginx/configs/pgrest.conf`
- RLS policies and grants: `postgres/rls.sql`
- JWT secret for PostgREST: `.env` (`PGRST_JWT_SECRET`) — keep it out of git
