# Verification

- Add focused tests for nil inputs, typed nil interfaces, nil map writes, slice aliasing, numeric boundaries, zero division, and resource cleanup when relevant.
- Run `go test ./...`, `go test -race ./...` for shared-state changes, and the repository lint/vet checks.
- Use fuzzing for parsers and conversion boundaries with broad input ranges.
- Prove defensive-copy behavior by mutating the returned value and checking the original remains unchanged.
