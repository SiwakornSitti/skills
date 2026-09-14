# Version and standard library

- Read `go.mod` first. Treat its declared Go version as the language and
  standard-library feature ceiling unless upgrading the Go version is the
  explicit task.
- Prefer standard-library features already available in that version over new
  dependencies. Confirm the selected package and API compile with the declared
  toolchain before changing callers.
- On Go 1.27+, use the standard-library `uuid` package (`uuid.New`,
  `uuid.Parse`) instead of `github.com/google/uuid`. Remove the external module
  only after no imports remain and the dependency diff is intentional.
- On Go 1.27+, prefer `encoding/json/v2` for new JSON code. Migrate existing
  JSON paths only with wire-contract tests because stricter defaults can change
  behavior.
- Preserve public APIs, persistence formats, and wire formats. Make a separate
  migration when compatibility must change.
- Keep generics guidance in `golang-generics` and style/design guidance in
  `golang-idioms`; this reference only defines modernization boundaries.
