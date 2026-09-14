# Context and queries

- Pass `context.Context` to every `ExecContext`, `QueryContext`, and
  `QueryRowContext` call.
- Bind values with driver-supported placeholders. Never interpolate untrusted
  values or client-supplied SQL fragments.
- Select only needed columns and scan them explicitly.
- Close `sql.Rows` and return `rows.Err()` after iteration.
