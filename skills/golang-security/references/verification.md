# Verification

- Add focused tests for unauthorized, forbidden, malformed, oversized, secret
  leakage, and replayed-request cases when those surfaces change.
- Run `go test ./...` for shared security or boundary changes.
- Run `go mod verify` and the repository vulnerability scanner for dependency
  changes.
- Inspect the built runtime image when Docker or build configuration changes;
  verify that credentials, source, compilers, and package managers are absent.
