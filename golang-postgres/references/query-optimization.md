# Query optimization

Follow `golang-sql` for driver-agnostic SQL optimization. Add PostgreSQL
specific changes only when a measured query or workload justifies them.

- Inspect the plan for hot or large queries with `EXPLAIN`; use
  `EXPLAIN (ANALYZE, BUFFERS)` in a safe test or staging environment to verify
  actual behavior. Do not run `EXPLAIN ANALYZE` on a mutating statement unless
  its effects are isolated and intentionally rolled back.
- Add indexes from measured filter predicates, joins, and ordering. Prefer a
  composite index that supports the query's leading predicates and sort order;
  avoid duplicate indexes and account for write and storage cost.
- Create or change indexes through migrations. Use concurrent index creation
  for production tables when the migration workflow supports it; it cannot
  run inside a transaction.
- Keep predicates sargable. Do not wrap indexed columns in functions or casts
  unless a matching functional index or equivalent design is intentional.
- Avoid N+1 queries. Fetch related data with a join or a bounded batch query
  when the use case needs a collection.
- Prefer keyset/cursor pagination for large or changing collections. Keep the
  established `limit`/`offset` contract for existing APIs unless migration is
  explicitly requested.
- Measure before and after with representative data. Do not claim an index or
  query rewrite is faster from SQL text alone.

```sql
EXPLAIN (ANALYZE, BUFFERS)
SELECT id, user_id, balance
FROM accounts
WHERE user_id = @user_id
ORDER BY created_at DESC, id DESC
LIMIT @limit
```
