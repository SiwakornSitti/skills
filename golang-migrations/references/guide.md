# Go Database Migrations

Use this skill when changing persistent schema, indexes, constraints, or migration execution.

- Add a new ordered migration; never edit a migration already applied to a shared environment.
- Keep `up` and `down` files reversible where the migration tool supports rollback; document irreversible data changes.
- Prefer transactional migrations when the database supports them. Test against the real database engine.
- Use expand-and-contract for deployed services: add compatible schema, deploy readers/writers, backfill, then remove old shape later.
- Make indexes and backfills operationally safe; estimate locks, runtime, and retry behavior before production.
- Run migrations as an explicit deployment step or job, not concurrently from every application replica.

Validate a new migration on a clean database and an upgrade database, then run repository integration tests.
