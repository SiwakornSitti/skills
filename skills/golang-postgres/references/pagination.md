# Pagination

Keep pagination deterministic with an explicit `ORDER BY` and the established
`limit`/`offset` contract. Include a unique tie-breaker when the primary sort
column is not unique, so rows are not skipped or repeated between pages.

```sql
SELECT id, user_id, balance, created_at
FROM accounts
ORDER BY created_at DESC, id DESC
LIMIT @limit OFFSET @offset
```

For cursor pagination, use a keyset predicate and fetch one extra row to derive
`has_more`; do not calculate a total count for every page.

```sql
SELECT id, user_id, balance, created_at
FROM accounts
WHERE user_id = @user_id
  AND (created_at < @cursor_created_at
       OR (created_at = @cursor_created_at AND id < @cursor_id))
ORDER BY created_at DESC, id DESC
LIMIT @limit_plus_one
```

Add an index that matches the filter and ordering, for example
`(user_id, created_at DESC, id DESC)`. Decode and validate the opaque cursor
before the repository; pass typed cursor values to SQL.
