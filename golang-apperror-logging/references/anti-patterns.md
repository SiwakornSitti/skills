# Anti-patterns

## Logging and Returning

```go
// BAD: Logging before returning the error
if err != nil {
    log.Error("failed query", "error", err)
    return nil, err
}
```

## Error Obfuscation

Replacing `fmt.Errorf("...: %w", err)` with `fmt.Errorf("...: %v", err)` breaks `errors.Is` and `errors.As` unwrapping.

## Logging Sensitive Data

Never log passwords, API keys, bearer tokens, or full credit card numbers in slog fields.
