# Fixtures and isolation

- Generate unique fixture identities and register `t.Cleanup` immediately after setup.
- Clean up dependent rows in a safe order; do not ignore cleanup failures when they can hide pollution.
- Avoid `t.Parallel` with shared infrastructure unless each test has isolated schema, database, or fixture state.
- Prefer per-test transactions only when the adapter contract supports rollback without masking the behavior under test.
- For parallel PostgreSQL tests using one container, prefer schema-per-test: create a unique schema, apply the real migrations with a test-scoped connection whose `search_path` targets that schema, and drop the schema with `CASCADE` during cleanup.
- Keep each schema-bound connection isolated from the shared pool until cleanup; do not rely on session-local `search_path` settings across pooled connections.
