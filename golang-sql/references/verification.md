# Verification

- Verify changed SQL with a focused repository integration test against the
  repository's actual database engine.
- Test row mapping, nullable values, not-found outcomes, affected-row
  behavior, pagination boundaries, and transaction rollback when applicable.
- Run `go test ./...` when a domain port, transaction boundary, or shared
  persistence package changes.
- Review the query plan and migration diff for optimization changes; do not
  claim performance improvement without workload evidence.
