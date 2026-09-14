# Query optimization

- Add indexes from measured query predicates, joins, and ordering. Match
  composite indexes to the query's filter and order direction.
- Verify index decisions with `EXPLAIN`. Create or change indexes through
  migrations.
- Avoid indexes that duplicate existing ones or impose unnecessary write cost.
- Avoid N+1 queries. Fetch related data with a join or bounded batch query when
  the use case needs a collection.
- Treat prepared statements and other execution changes as evidence-based
  optimizations, not defaults.
