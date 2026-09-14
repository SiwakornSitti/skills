# Distributed tracing

To tie the single downstream log entry to upstream requests across services, always propagate the W3C `traceparent` header in HTTP requests:

```go
func doOutboundRequest(ctx context.Context, req *http.Request) {
    otel.GetTextMapPropagator().Inject(ctx, propagation.HeaderCarrier(req.Header))
}
```

This lets log aggregators connect the single root-cause log entry with the complete distributed trace.
