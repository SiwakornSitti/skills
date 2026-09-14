# APIs and events

Expose a core capability through a stable contract, not through its internal entities or tables. HTTP and gRPC handlers should translate transport requests to use-case commands and map results at the boundary.

For asynchronous consumers, assume at-least-once delivery: validate the message, enforce idempotency before side effects, acknowledge only after durable success, and route exhausted or non-retryable failures according to the broker contract.

Publish an event only after the state change it describes is durable. Use a transactional outbox when the database write and event publication must not diverge. Events should contain stable identifiers and versioned facts, not private persistence models or secrets.

Keep synchronous responses and events semantically consistent. If a client needs a new business fact, extend the owning service contract rather than making a BFF reconstruct it from unrelated calls.
