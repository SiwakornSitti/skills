# Boundary translation

Translate errors at the boundary that understands both the source and the
destination contract.

- Map adapter-specific errors to domain errors in the adapter; PostgreSQL
  mappings belong to `golang-postgres`.
- Handlers map known domain errors to the established HTTP status and
  `httpserver` error code. Unexpected failures use the internal-error response
  without exposing implementation details.
- For new or explicitly migrated HTTP contracts, return
  `{"error":{"code":"...","meta":{...}}}`. Keep `code` stable, include
  only safe actionable metadata, and omit `meta` when none applies. Preserve
  the current flat response until migration is explicitly requested.
- Consumers decide retry, acknowledgement, or dead-letter behavior at the
  inbound boundary.
- Errors must retain causes even when an HTTP response intentionally hides
  them. Distributed structured errors follow `golang-apperror-logging`.

```go
switch {
case errors.Is(err, domain.ErrNotFound):
	return http.StatusNotFound, "ACCOUNT_NOT_FOUND"
default:
	return http.StatusInternalServerError, "INTERNAL_ERROR"
}
```
