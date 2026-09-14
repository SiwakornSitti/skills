# Dependencies

- Modernize one dependency concern at a time. Do not combine unrelated module
  upgrades with source refactoring.
- Use Go tooling for upgrades and inspect the resulting `go.mod` and `go.sum`
  diff. Run `go mod tidy` only after the intended dependency graph is complete.
- Read release notes before a major-version upgrade. Account for breaking
  changes in every caller, adapter, test, and deployment build.
- Treat major dependency upgrades as an explicit compatibility task; do not
  silently bundle them into routine cleanup.
- Prefer an existing dependency or the standard library over adding a new
  package for a small helper.
