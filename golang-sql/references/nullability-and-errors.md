# Nullability and errors

- Map nullable columns explicitly with `sql.Null*` types or repository-owned
  nullable types. Do not scan `NULL` into non-nullable Go values.
- Map `sql.ErrNoRows` to the context's not-found error at the repository
  boundary.
- Wrap operational failures with query context and preserve their cause. Do
  not log database errors in the repository; log once at the owning boundary.
