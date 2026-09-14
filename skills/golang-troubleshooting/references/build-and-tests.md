# Builds and tests

- Start with the narrowest failing package or test, then run the broader command to detect integration effects.
- Use `go build ./...`, `go vet ./...`, and `go test ./...` as appropriate; preserve the exact failing output.
- Isolate flaky tests by repetition, controlled ordering, timeouts, and fixture inspection.
- Use `go test -race ./...` for suspected shared-state failures and keep timing-sensitive fixes evidence-based.
- Separate toolchain, dependency, environment, and application failures in the report.
