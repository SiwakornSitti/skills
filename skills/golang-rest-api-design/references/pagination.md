# Pagination

## Pagination and filtering

- Use the established `limit` and `offset` query parameters through
  `httpserver.QueryInt`, and return `httpserver.NewPage(data, limit, offset,
  total)`.
- Apply limit and offset consistently to both the data query and response
  metadata. Define a finite maximum limit and safe defaults.
- Keep ordering deterministic, preferably by a stable field plus a unique
  tie-breaker.
- Validate filters before passing them to the domain layer. Parameterize
  repository queries; never concatenate user input into SQL.
- Introduce cursor pagination as an explicit contract change; never silently
  change offset semantics.

## Cursor pagination

- Use an explicit `after`/`next_cursor` contract for large or changing
  collections; do not mix cursor and offset parameters in one request.
- Keep cursors opaque and URL-safe. Encode the cursor version, ordering
  position, and relevant filter identity; sign or authenticate stateless
  cursors before trusting decoded values.
- Return `items`, `next_cursor`, and `has_more`. Use `next_cursor: null` at the
  end; avoid an exact total count unless the contract requires its cost.
- Reject malformed, expired, or filter/order-mismatched cursors with `400`.
- Keep ordering stable and unique, and document whether the cursor moves
  forward or backward. Translate the cursor at the boundary; the domain and
  repository receive typed position values, not encoded strings.
