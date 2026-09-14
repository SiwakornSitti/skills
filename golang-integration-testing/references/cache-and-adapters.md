# Cache and external adapters

- Test cache behavior against the real cache service when claiming Redis/Valkey semantics such as serialization, TTL, eviction, atomicity, or reconnect behavior.
- Treat an in-memory cache wrapper as unit/adapter logic coverage, not proof of Redis behavior.
- Verify outbox and other external adapters against the real protocol/service when serialization, delivery, or persistence semantics matter.
- Keep adapter-specific setup in the owning skill (`golang-postgres`, `golang-redis`, etc.).
