# Key validation

- Bound key size and define an accepted format before using a key in storage.
- Authenticate or scope keys to the caller and operation before lookup.
- Hash or otherwise protect storage keys when required by the store, but keep
  the mapping deterministic for replay and conflict checks.
- Never log raw idempotency keys or place them in metric labels, URLs, or error
  responses.
