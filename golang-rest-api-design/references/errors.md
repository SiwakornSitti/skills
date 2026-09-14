# Errors

## Error mapping

Map errors from most specific to least specific:

| Condition | HTTP status | Response code |
| --- | --- | --- |
| Malformed or structurally invalid request | 400 | shared bad-request code |
| Missing resource | 404 | context-specific not-found code |
| Duplicate resource or idempotency conflict | 409 | existing conflict code |
| Valid request rejected by a domain rule | 422 | stable domain-rule code |
| Unexpected dependency or infrastructure failure | 500 | internal-error code |

- Reuse an existing `httpserver.ErrCode...` when it describes the outcome. Add
  a context-specific code only when clients need to distinguish a new stable
  failure case.
- Use `errors.Is` and `errors.As`, never error-string comparisons.
- Return stable safe messages and codes. Keep diagnostic detail in the boundary
  log; do not pass `err.Error()` to clients by default.
- Pass the underlying error to `WriteError` only when it should be logged at
  the boundary. Do not log the same error in the handler and `WriteError`.
