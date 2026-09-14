# Execution and storage

- Make the business write and idempotency record atomic when they share a
  database; use the existing Unit of Work where available.
- When the idempotency store is external to the business database, define the
  recovery, deduplication, and reconciliation path explicitly.
- Do not record completion before the side effect reaches its defined success
  point.
- Do not silently ignore claim, read, or completion-storage errors when doing
  so can permit duplicate side effects.
