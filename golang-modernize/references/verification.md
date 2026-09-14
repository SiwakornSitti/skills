# Verification

- Format every changed Go file with `gofmt`.
- Run focused tests for the affected package and callers. Add or update
  contract tests for JSON, UUID, persistence, or other wire-format changes.
- Run `go vet ./...` when the change crosses packages or changes shared code.
- Run `go test ./...` when the change crosses packages, shared APIs, or
  dependency versions; focused tests are enough for an isolated local idiom.
- Run `go mod tidy` only when the dependency graph changed, then review
  `go.mod` and `go.sum` for unrelated upgrades or removals.
- Finish with a diff review and `git diff --check`. Do not claim compatibility
  until the relevant callers and tests pass.
