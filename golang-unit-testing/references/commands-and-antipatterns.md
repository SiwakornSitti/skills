# Commands and anti-patterns

Use direct Go commands for fast feedback:

```bash
# All unit tests
go test ./...

# Verbose unit tests
go test -v ./...

# Race-sensitive changes
go test -race ./...

# Integration-tagged tests
go test -tags=integration ./...
```

In this repository, `make test` and `make test-verbose` also run `check-tools`
before invoking Go. Use them when the repository toolchain check is intended;
use direct `go test` commands when diagnosing unit behavior. Do not claim that
unit tests cover database, cache, broker, or filesystem compatibility.

## Anti-patterns

- Starting real infrastructure in a unit test.
- Sharing mocks, fixtures, or mutable globals across table cases.
- Testing private implementation details instead of the public contract.
- Comparing exact error strings when `errors.Is` or `errors.As` expresses the
  contract.
- Using sleeps, unbounded goroutines, or wall-clock retries.
- Asserting every mock call when only the returned behavior matters.
- Returning raw internal errors or unstable JSON details as an HTTP contract.
- Copying examples from another router or dependency set without compiling
  them against this repository.
- Requiring coverage, fuzzing, or benchmark thresholds without a measured
  requirement.
