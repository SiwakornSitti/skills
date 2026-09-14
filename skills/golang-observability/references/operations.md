# Operations

## Boundaries

Use logs for discrete diagnostic events, metrics for aggregation, and traces
for a single request or message journey. Choose the lowest-cost signal that
answers the operational question.

- For HTTP, instrument the route template rather than the raw URL path. Record
  the final status after the handler completes, with method, status class, and
  duration. Redact query parameters and request headers by default.
- For consumers, create one span per message and propagate its trace context
  when available. Record delivery outcome as `ack`, `retry`, or `dead_letter`.
  Bound topic, consumer, and event-type metadata; never log the full payload.

## Errors, retries, and circuit breakers

- Wrap errors with `%w`; classify them with `errors.Is` and `errors.As` at the
  boundary. Lower layers return errors and annotate spans but do not log the
  same failure.
- Record retry count, final outcome, and dependency name as bounded fields.
  Do not emit an error log for every retry when the final boundary log can
  summarize the attempts.
- Treat circuit-breaker state changes as low-volume warning events with
  breaker name and old/new state. Do not log every rejected request unless it
  answers a stated alerting question.
- Keep observability metadata in logs, spans, and metrics; do not change the
  established HTTP error response shape.

## Lifecycle

- Initialize providers once during startup and shut them down with the
  service's root context. Flush exporters before process exit when configured.
- Keep telemetry initialization separate from business logic so tests can use
  a no-op provider or in-memory recorder.

## Privacy and cost

- Assume telemetry is retained outside the service boundary. Allow-list fields
  instead of serializing arbitrary structs. Redact passwords, tokens,
  authorization headers, cookies, payment data, and raw personal data.
- Sample or lower the level of high-volume success paths only after failure
  visibility is preserved. Never sample away required audit or security events.

## Verification

- Test the observable contract, not SDK internals: assert bounded log fields,
  span name/status, metric name/labels, or propagation headers.
- A focused test or local request verifies instrumentation, not backend
  delivery. Do not claim telemetry reached a collector or dashboard without a
  live export check.

## Anti-patterns

- Logging and returning the same error at repository, service, and handler
  layers.
- Creating spans in every small function or recording the same duration in
  multiple layers.
- Using IDs, raw paths, error messages, or payload values as metric labels.
- Starting detached goroutines that outlive the request context without an
  explicit lifecycle.
- Adding a new exporter or vendor SDK merely to make a local test pass.
