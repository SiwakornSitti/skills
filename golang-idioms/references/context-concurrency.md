# Context and concurrency

## Context as First Parameter

Always pass `ctx context.Context` as the very first parameter to any function performing I/O, persistence, or network requests:

```go
func (r *repository) FindByID(ctx context.Context, id string) (*domain.Account, error)
```

- Never store `context.Context` inside a struct.
- Always propagate `ctx` to database calls and HTTP clients.

## Goroutine Ownership and Termination

- Always tie background goroutines to a `context.Context` lifecycle via `ctx.Done()`.
- Ensure clean termination with tickers and `sync.WaitGroup`.
