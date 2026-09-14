# Contract and scope

- Define the `X-Idempotency-Key` header, applicable operations, key scope,
  retention period, and replayed response contract explicitly.
- Apply idempotency to retriable side-effecting commands, especially financial
  resource creation, when the API contract requires it.
- Bind a key to the authenticated caller, operation, and resource owner. A key
  is not globally reusable across callers or unrelated operations.
