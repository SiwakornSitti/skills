# Persistence and transactions

The core service owns its database schema and repository behavior. Callers must not read or write that database to compose a result or enforce a rule.

Use a transaction when one business operation must atomically update multiple owned records or record an outbox event. Keep the transaction boundary around the use-case operation, pass the transaction context to repositories, and commit only after all invariants and writes succeed.

Do not hold a database transaction across remote HTTP/gRPC calls or broker delivery. For cross-service workflows, use an explicit state machine, idempotency contract, saga, or transactional outbox as appropriate.

Repositories map storage rows to domain values and preserve not-found, conflict, and constraint semantics. They must not leak driver-specific errors into the domain. Verify query cardinality, context cancellation, rollback, commit failure, and retry safety.
