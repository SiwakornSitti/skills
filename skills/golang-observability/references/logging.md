# Logging

Instrument only a question the service needs to answer: what failed, how long
it took, or how much work occurred. Reuse the repository's `slog` wiring; do
not add an exporter or backend without a deployment requirement.

- Emit structured `slog` fields, not formatted lines. Use stable operation,
  event, and outcome fields; never log secrets, credentials, tokens, or raw
  PII.
- Prefer `logger.FromContext(ctx).InfoContext(ctx, ...)` or the matching level
  so context and trace correlation are retained.
- Use Debug for high-volume troubleshooting, Info for meaningful lifecycle
  events, Warn for degraded recoverable behavior, and Error for a failed
  boundary operation.
- Do not log normal successful internal calls, health checks, or polling
  iterations unless they answer a stated diagnostic question.
- Follow `golang-apperror-logging`: log failures once at the inbound boundary
  and wrap them through lower layers.
- Do not duplicate fields already added by the repository logger or middleware.

## Context and correlation

- Propagate `context.Context` as the first parameter through handlers,
  consumers, use cases, repositories, database calls, cache calls, and HTTP
  clients. Never create `context.Background()` inside request work.
- Derive a request-scoped logger with `With`; never mutate a shared logger from
  a request handler.
- Add trace and span IDs to logs through the existing logger/middleware
  integration. Request IDs may be logged for lookup, but must not become
  metric labels.
- Validate or bound correlation headers before logging them. Never copy
  authorization or cookie headers into logs.
