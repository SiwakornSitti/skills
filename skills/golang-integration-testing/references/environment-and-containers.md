# Environment and containers

- Prefer `TEST_DATABASE_URL`, then `DATABASE_URL`, then an ephemeral Testcontainers PostgreSQL instance.
- Use `REDIS_URL` when supplied; otherwise start an ephemeral Redis container for real Redis tests.
- Use dynamic ports and parse supplied URLs; never hardcode ports or credentials.
- Use safe test credentials only in ephemeral/local test configuration.
- When current harness behavior differs from this policy, preserve the policy and track harness alignment separately.
