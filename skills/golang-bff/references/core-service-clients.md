# Core-service clients

Represent each upstream dependency with the smallest outbound port the BFF use case needs. Put HTTP, gRPC, authentication headers, serialization, status mapping, and retry mechanics in the adapter.

```go
type AccountReader interface {
	GetBalance(context.Context, AccountID) (Money, error)
}
```

The use case should depend on `AccountReader`, not an HTTP client, gRPC stub, generated transport model, or URL. Keep adapters responsible for translating wire payloads into BFF-facing values and for preserving useful upstream error identity.

Core-service client rules:

- use context-aware calls and never detach the request context;
- set explicit connect, header, and total request deadlines;
- send only the fields and headers required by the upstream contract;
- propagate a trusted correlation/request ID and authorization context according to the platform contract;
- validate response status, content type, required fields, and bounded body size;
- close response bodies and avoid logging raw request or response payloads;
- version or contract-test the client when the upstream schema changes.

Use separate clients or ports for separate ownership boundaries. A single “core client” with arbitrary methods hides coupling and makes fan-out, retries, and failure policy difficult to audit.
