# Go MySQL

Use this skill for MySQL-specific repository, schema, connection, or transaction changes. Read the repository, domain port, migration, and callers before editing.

- Use `database/sql` with the repository's MySQL driver. Keep driver types out of domain services.
- Pass `context.Context` to every `ExecContext`, `QueryContext`, and `QueryRowContext`; bind values with `?` placeholders and never interpolate untrusted input.
- Configure DSNs deliberately (`parseTime`, location, TLS, and connection limits); keep credentials outside source and logs.
- Select only needed columns, scan explicitly, close `sql.Rows`, and return `rows.Err()` after iteration.
- Map `sql.ErrNoRows` to the context's not-found error. Check affected-row counts for updates and deletes.
- Use the existing transaction boundary for atomic writes. Keep pagination deterministic with explicit `ORDER BY` and indexed predicates.
- Test queries against the supported MySQL version, including transaction rollback, duplicate-key, not-found, and timeout behavior.

Run `go test ./...` after changing a repository port, transaction boundary, or shared persistence package.
