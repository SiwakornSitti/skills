# Use cases and ports

For a single bounded context, implement the application operation directly in `service/`; a separate `usecase/` package is unnecessary. Use a `usecase/` layer only when the workflow is a real cross-context or cross-service orchestration boundary.

The application operation expresses business behavior in business language. It validates and orchestrates domain behavior, calls narrow ports, and defines the order and atomicity of side effects.

```go
type TransferService struct {
	accounts AccountPort
	transfers TransferPort
}

func (s *TransferService) Create(ctx context.Context, cmd CreateTransfer) (Transfer, error) {
	// validate command, enforce domain rules, persist through ports
	return Transfer{}, nil
}
```

Rules:

- accept `context.Context` first and honor cancellation;
- expose intent-based methods such as `Create`, `Approve`, or `ListByAccount`, not generic CRUD when behavior matters;
- keep interfaces at the consumer side and make them as small as the use case requires;
- return domain values and typed/domain errors, not transport responses;
- keep orchestration in the use case and invariant enforcement in the domain model;
- do not add an interface, factory, or generic workflow abstraction with no second real implementation.

Inbound adapters translate HTTP, gRPC, or messages into commands. Outbound adapters implement ports for databases, core-service clients, queues, and external providers.
