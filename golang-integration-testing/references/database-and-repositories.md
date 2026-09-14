# Database and repositories

- Verify repository row mapping, constraints, not-found errors, affected-row behavior, and transaction boundaries against the actual database engine.
- Prove Unit of Work commit and rollback, including absence of partially persisted rows after failure.
- Use real schema and driver behavior for persistence assertions; use unit doubles for domain/business logic.
- Pass test contexts through repository calls and keep fixtures in the adapter boundary.
