# Replay and failures

- Persist the completed status, response body, and allow-listed required
  headers before acknowledging a successful operation.
- Replay the stored result without repeating side effects. Mark replayed
  responses clearly when the public contract requires it.
- Do not permanently record transient failures unless the API contract requires
  it. Keep retryable failures distinct from completed results.
- Define store-failure behavior before execution. For non-idempotent financial
  or command operations, fail closed when a claim cannot be made safely.
