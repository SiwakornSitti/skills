# Queries and mapping

Use this skill for PostgreSQL-specific repository changes. Read the repository,
domain port, migration, and callers before editing.

- Pass `context.Context` from the caller to every pgx operation. Do not create
  `context.Background()` inside repository methods.
- Bind values with `pgx.NamedArgs` or positional arguments; never interpolate
  untrusted values into SQL. Use the style that keeps each query readable.
- Select only needed columns and scan them explicitly. Do not use `SELECT *`.
- Close `pgx.Rows` and return `rows.Err()` after iteration.
- Map `pgx.ErrNoRows` to the context's not-found error at the repository
  boundary. Wrap operational failures with query context; do not log them
  there.
- Check affected-row counts when a successful write must affect an existing
  row.
- Configure pool limits from workload and the total PostgreSQL connection
  budget; do not copy fixed values blindly. The application owns pool startup
  and must close the pool during graceful shutdown.
- Emit bounded query operation identifiers and duration, not raw parameters,
  credentials, or personal row data.

```go
const query = `
	SELECT id, user_id, balance
	FROM accounts
	WHERE id = @id`

var account domain.Account
err := db.QueryRow(ctx, query, pgx.NamedArgs{"id": id}).Scan(
	&account.ID, &account.UserID, &account.Balance,
)
if errors.Is(err, pgx.ErrNoRows) {
	return nil, domain.ErrNotFound
}
if err != nil {
	return nil, fmt.Errorf("find account: %w", err)
}
```
