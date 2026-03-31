# Database

This document outlines the best practices for database interactions, query optimization, and schema management.

## 1. Connection & Tooling

- **Connection Pooling:** Use `database/sql`'s built-in connection pooling. Configure `SetMaxOpenConns`, `SetMaxIdleConns`, and `SetConnMaxLifetime` appropriately based on the expected load and database capacity to prevent connection exhaustion.
- **No ORM Preferred:** Avoid using heavy ORMs (e.g., GORM) for core business logic. They often introduce performance overhead, hidden N+1 queries, and obscure actual SQL logic. Prefer writing raw SQL or using lightweight toolkits like `sqlc` or `sqlx` to maintain full control over query performance and readability.

## 2. Schema Design

- **Primary Keys:**
  - **UUIDv7:** If using UUIDs as primary keys, you **must** use UUIDv7. Its time-ordered, sortable nature provides significantly better database indexing and insertion performance compared to fully random UUIDs (like v4).
- **Date and Time:**
  - **Timezones:** All datetime columns **must** store timezone information (e.g., use `timestamptz` or `TIMESTAMP WITH TIME ZONE` in PostgreSQL). Never store times without a timezone context to prevent data inconsistencies and logic errors across different regions.
- **Soft Deletes vs Hard Deletes:** Prefer soft deletes (e.g., adding a `deleted_at` column) for critical business data (users, orders, payments) to maintain historical records and allow for data recovery. Use hard deletes only for transient or PII data that must be legally purged.
- **Database Migrations:**
  - **Schema Versioning:** All database schema changes **must** be managed via versioned migration files stored in the `/migrations` folder.
  - **No Manual Changes:** Never apply schema changes manually directly to the database. Every structural change must be captured in a migration script (using tools like `golang-migrate` or `pressly/goose`).
  - **Down Migrations:** Always include a "down" script (or rollback logic) for each "up" migration to ensure safe rollbacks.

## 3. Query Optimization & Security

- **Prevent SQL Injection:** **Always** use parameterized queries or prepared statements for dynamic values. Never use `fmt.Sprintf` or string concatenation to build queries with user-supplied input.
- **Named Parameters:** To improve readability and maintainability, **must** use named parameters (e.g., `:user_id`, `@email`) instead of positional placeholders like `$1` or `?`. This makes queries self-documenting and less error-prone when modifying the parameter order.
- **Indexing:**
  - Use indexes on frequently queried columns, foreign keys, and columns used in `JOIN`, `WHERE`, and `ORDER BY` clauses.
  - Avoid over-indexing, as it degrades `INSERT`/`UPDATE` performance.
  - Consider composite indexes for queries that filter on multiple columns simultaneously.
- **Avoid `SELECT *`:** Only select the specific columns needed for your application logic. This reduces memory usage, network bandwidth, and prevents breaking changes when the schema evolves.
- **Transactions:** Use database transactions (`BEGIN`, `COMMIT`, `ROLLBACK`) to ensure data integrity for atomic operations that modify multiple records or tables.
- **Context and Timeouts:** **Always** use context-aware database methods (e.g., `QueryContext`, `ExecContext` in `database/sql`). Pass the request's context down to the database layer to ensure queries are cancelled if the client disconnects or if a timeout is reached, preventing database connection exhaustion.
- **Avoid N+1 Queries:** Do not execute a separate query inside a loop to fetch child records. Use `JOIN`s, or fetch data in bulk using batch fetching (`WHERE id IN (...)`).
- **Cursor Paging:** For endpoints returning large lists of data, implement cursor-based pagination (e.g., `WHERE id > :last_seen_id ORDER BY id ASC LIMIT 10`) instead of `OFFSET` pagination, which degrades severely in performance on large datasets.
