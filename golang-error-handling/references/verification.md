# Verification

When an error contract changes, test the error chain, typed or sentinel match,
boundary status/code, safe response shape, and hidden internal cause.

Test each sentinel with `errors.Is` and each typed error with
`errors.AsType[T]`; do not assert human-readable error text as the contract.

```go
if !errors.Is(err, domain.ErrNotFound) {
	t.Fatalf("errors.Is(%v, ErrNotFound) = false", err)
}

if _, ok := errors.AsType[*domain.ValidationError](err); !ok {
	t.Fatal("expected ValidationError")
}
```

Verify that known domain errors translate to their established client
contract, while unexpected errors become the internal-error response without
leaking raw causes, stack traces, credentials, or personal data.
