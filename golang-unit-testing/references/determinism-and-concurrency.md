# Table cases, determinism, and concurrency

## Table-driven tests

Use table-driven tests when cases share the same unit and assertion shape. Keep
scenario-specific setup in a callback:

```go
tests := []struct {
	name    string
	setup   func(*mocks.MockRepository)
	wantErr error
	check   func(*testing.T, *domain.Account)
}{
	// cases...
}

for _, tt := range tests {
	t.Run(tt.name, func(t *testing.T) {
		repo := mocks.NewMockRepository(t)
		tt.setup(repo)
		// Construct the service and execute the case here.
	})
}
```

Create all mutable state inside the subtest. Use `t.Parallel()` only after
checking that the case has no shared globals, environment changes, mock state,
temporary resource, or ordering dependency.

## Context, time, and randomness

- Pass `context.Context` through the unit boundary and assert that cancellation
  reaches blocking ports.
- Inject clocks, ID generators, and random sources when their values affect the
  decision under test.
- Use deterministic doubles rather than wall-clock timing or global randomness.
- Register cleanup with `t.Cleanup` and ensure every goroutine has a bounded
  exit path.

## Concurrency

- Use channels, wait groups, controllable fakes, and context deadlines to
  coordinate goroutines.
- Do not use `time.Sleep` to wait for a goroutine or retry loop.
- Test bounded concurrency and cancellation behavior, not scheduler timing.
- Run focused concurrent tests with `go test -race`.

The test must not depend on scheduler speed, network availability, or
process-global mutable configuration.

## Optional fuzzing and benchmarks

Use fuzz tests for parsers, decoders, and validators when malformed-input space
is broad and the property is clear. They are optional, not a default requirement
for ordinary service tests.

Add benchmarks only for demonstrated performance-sensitive code. Keep them
separate from correctness tests and record the workload before optimizing.
