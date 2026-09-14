# Cross-context orchestration

- Put a workflow that coordinates contexts in `usecase/` owned by the initiating context.
- Define a narrow port at the caller boundary and inject it at application composition time.
- Keep foreign domain contracts in the boundary adapter used for wiring; map them to caller-owned commands, DTOs, or result types before entering the usecase.
- Use a synchronous interface when the caller needs an immediate result; use an outbox-backed event when the handoff is durable or asynchronous.
- Each bounded context owns its local transaction. Never share a database transaction or pretend a remote call is part of local atomicity.
- Keep remote calls outside local Unit of Work transactions unless the operation is explicitly modeled as a local durable handoff.
- In a modular monolith, an in-process domain service is still a context boundary: pass it only into the consuming adapter at module composition time.
- Keep event-to-command mapping in the initiating context's `usecase/`; pass that handler to a generic outbox relay from the module.

```go
type useCase struct {
	accounts AccountReader
	users    domain.Service
}

type AccountReader interface {
	GetByUserID(ctx context.Context, userID string) (*domain.AccountSummary, error)
}
```

Keep cross-context result types narrow and caller-facing. Map another context's
domain entity at `outbound/<dependency>/` instead of making the caller depend on
the callee's full entity model.
