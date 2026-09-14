# Caching and database handoff

- Cache repeated expensive work only when measurement shows reuse and invalidation can be made correct.
- Include serialization, memory growth, TTL, stampede, and stale-data costs in the cache decision.
- Hand slow SQL to [golang-sql](../../golang-sql/SKILL.md) or the owning Postgres/MySQL skill; verify query plans before changing application code.
- Keep cache implementation and invalidation rules in [golang-cache](../../golang-cache/SKILL.md).
