# BFF verification

Verify the composition policy, not only the happy-path JSON.

Minimum checks:

- unit-test the use case with ports for success, required failure, optional failure, timeout, cancellation, malformed data, and empty results;
- assert independent calls are bounded and dependent calls receive the prior validated result;
- test the client DTO allowlist, nullability, units, ordering, pagination, and degraded marker;
- contract-test each core-service adapter against its status codes, auth propagation, error shape, and schema limits;
- endpoint-test authentication, request validation, client disconnect/cancellation, and stable error translation;
- verify retry attempts, backoff limits, idempotency requirements, and no retry on permanent errors;
- verify logs, traces, and metrics contain correlation without tokens, PII, raw payloads, or unbounded upstream labels;
- statically reject imports of core repositories/private packages and shared-database access.

Use a failure matrix for every aggregate:

| Dependency | Required? | Timeout result | Permanent error | Transient error | Client output |
| --- | --- | --- | --- | --- | --- |
| Core service A | yes/no | defined | defined | defined | defined |

Keep tests deterministic: inject clocks/backoff or disable real sleeping in unit tests, and use fake ports for orchestration. Reserve live multi-service tests for a small number of contract or integration cases.
