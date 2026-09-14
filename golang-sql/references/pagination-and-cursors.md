# Pagination and cursors

- Prefer cursor/keyset pagination for large or changing collections. Use
  offset only when the public contract requires it.
- Order by stable fields plus a unique tie-breaker.
- Keep cursors opaque and bounded. Validate decoded values and reject malformed
  or expired cursors.
- Example predicate: `created_at < cursor.created_at OR (created_at =
  cursor.created_at AND id < cursor.id)`, ordered by `created_at DESC, id DESC`.
- Bind each cursor value with the selected driver's placeholder syntax.
