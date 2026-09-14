# Verification

Verify changed SQL with a focused repository integration test against real
PostgreSQL. Cover successful reads and writes, `pgx.ErrNoRows` mapping,
affected-row behavior, row iteration errors, and pagination ordering when
those paths change.

Run `go test ./...` when a domain port, transaction boundary, or shared
database package changes. Use the smallest relevant repository test first.

Keep readiness and health checks at the application or deployment boundary,
not inside repository methods.
