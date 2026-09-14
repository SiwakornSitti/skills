# Freshness and invalidation

- Use a finite TTL as a safety net, not as the only consistency mechanism for mutable data.
- Invalidate or refresh every key affected by a successful mutation, including alternate lookup keys and collection entries.
- With a Unit of Work, delay cache changes until the database transaction commits. Never publish a cache value for a rolled-back write.
- Prefer updating a complete immutable value over mutating a shared cached object.
- Version key namespaces when changing serialization or meaning. Let old entries expire or remove them through an explicit migration.
- Use namespaced, versioned keys and centralize key construction for reads, writes, deletes, and invalidation.
- Treat the backend's documented missing-value result as a miss only where absence is expected.
- Cache immutable values or copies. Do not return a shared mutable cached object.
- Write the source of truth first. Cache changes happen only after the write succeeds.

Related implementation guidance:

- [golang-redis](../../golang-redis/SKILL.md) — Redis key and TTL behavior.
- [golang-valkey](../../golang-valkey/SKILL.md) — Valkey key and compatibility behavior.
- [golang-unit-of-work](../../golang-unit-of-work/SKILL.md) — transaction commit boundaries.
