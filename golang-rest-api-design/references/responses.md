# Responses

- Return response DTOs and explicitly map domain values, including timestamps
  and nullable fields. Never expose persistence models accidentally.
- Use `httpserver.WriteJSON` for success and `httpserver.WriteError` for
  failures so headers, the error envelope, and log-once behavior stay uniform.
- Set the status before the body and return immediately after a terminal
  response. A `204 No Content` response has no JSON body.
- Keep the established success contract: `201 Created` for creation, `200 OK`
  for reads and updates, and `204 No Content` for deletion.
- Set `Content-Type` through `httpserver.WriteJSON` and do not write internal
  error text, SQL details, stack traces, or secrets to clients.

## Headers

- Prefer registered standards when one exists, such as W3C `traceparent` and
  `tracestate` for distributed tracing.
- Name application headers descriptively and omit the deprecated `X-` prefix;
  use `Idempotency-Key`, for example.
- Treat header names as public API. Preserve existing names unless a migration
  and compatibility plan are explicit.

See [W3C Trace Context](https://www.w3.org/TR/trace-context/) and
[RFC 6648](https://www.rfc-editor.org/info/rfc6648/).
