# Idempotency

- Use the existing idempotency middleware/store for retriable creates or
  commands when the contract requires at-most-once effects.
- Scope an idempotency key to the authenticated caller and operation. Reject
  reuse with a different request payload.
- Persist or replay the complete response only after the operation reaches its
  defined success point. Never cache a `5xx` response as a successful result.
- Preserve request cancellation. Avoid holding locks or database transactions
  while writing an unrelated response.

`golang-idempotent` owns idempotency semantics; this skill owns their HTTP
integration.
