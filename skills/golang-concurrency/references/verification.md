# Verification

- Run focused tests with `go test -race` for changed concurrent code.
- Add tests for cancellation while producing, cancellation while processing,
  channel closure, all workers completing, and first-error propagation when a
  new goroutine or channel path is introduced.
- Exercise bounded worker and queue limits; verify no producer or worker can
  remain blocked after cancellation.
