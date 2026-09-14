# Verification

- Run integration tests with `go test -v -tags=integration ./internal/...` (or the repository’s equivalent command).
- Verify build-tag isolation with ordinary `go test ./...`.
- Cover setup failure, readiness, cleanup, duplicate/cross-test state, malformed schema/migration, repository errors, rollback, cache TTL, and external-adapter failure as relevant.
- Use live infrastructure evidence for claims about database/cache/service behavior; a fake or in-memory test cannot prove those claims.
