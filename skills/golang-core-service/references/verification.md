# Core-service verification

Verify the rules at the owning service, then verify each adapter at its boundary.

Minimum checks:

- unit-test entities and use cases for valid and invalid transitions, authorization decisions, conflicts, and idempotent replays;
- test transaction commit, rollback, context cancellation, and partial-write prevention;
- integration-test repository mapping, constraints, not-found behavior, and query cancellation;
- contract-test HTTP/gRPC/message schemas, error mapping, versioning, and event payloads;
- test outbox or workflow recovery when state persistence succeeds but publication or a remote step fails;
- verify no inbound adapter or BFF imports repositories or private domain internals;
- verify logs, traces, and metrics are correlated and redact sensitive values.

Prefer deterministic fakes for use-case tests and a small number of integration tests for real databases or brokers. Add a new abstraction only when a test or second implementation demonstrates the seam is needed.
