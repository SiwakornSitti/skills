# Transactions and Unit of Work

- Use the existing pgx Unit of Work for atomic writes through multiple
  repositories in one bounded context. A read-only query or single-repository
  operation does not need transaction coordination.
- The service or use-case layer owns begin, commit, and rollback. Repositories
  use the transaction passed through their typed Unit of Work accessor.
- Use PostgreSQL's default transaction options unless a concrete isolation or
  locking requirement justifies changing them.
- Keep remote calls and message publication outside the local transaction;
  use the transactional outbox when durable handoff is required.
- Do not retry transactions generically. If serialization or deadlock errors
  require retry, retry the complete idempotent operation at an explicit
  application boundary.
