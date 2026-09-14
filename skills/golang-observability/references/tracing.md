# Tracing

- Create spans at inbound HTTP requests, message consumption, and outbound
  calls—the boundaries where latency and failure ownership change. Do not
  create spans for every helper function.
- Name spans with stable operations such as `account.get` or
  `postgres.account.find`. Never use raw IDs, emails, query strings, or
  unbounded URLs as span names.
- Add only useful, bounded attributes: HTTP method and route template,
  messaging system/topic, dependency, operation, result status, and error code.
- On failure, record the error and set span status to error. Follow service
  policy for expected domain outcomes such as not-found or validation failure.
- Call `defer span.End()` immediately after creation and ensure spans end on
  success, error, panic recovery, and cancellation.
- Preserve W3C trace context on outbound HTTP and message requests. Reuse
  existing `otelhttp` or client instrumentation; do not create duplicate spans.

```go
req = req.WithContext(ctx)
otel.GetTextMapPropagator().Inject(ctx, propagation.HeaderCarrier(req.Header))
```
