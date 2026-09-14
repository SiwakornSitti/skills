# Claude Code Guide — Skills Repository

Welcome Claude Code. This repository contains a modular library of **43 engineering skills** focusing on Go, Hexagonal Architecture, high-concurrency systems, security, and clean code standards.

## How to Use Skills in Claude Code

When working on user queries or coding tasks:
1. **Discover Skills**: Skills are accessible natively via `.claude/skills/<skill-name>/SKILL.md` or directly at `./skills/<skill-name>/SKILL.md`.
2. **Progressive Reading**:
   - Only read the specific `SKILL.md` needed for the immediate query.
   - Deep-dive into `./skills/<skill-name>/references/` only when resolving intricate edge cases or specific patterns.
3. **Execution**:
   - Helper scripts are under `skills/<skill-name>/scripts/` (e.g. `skills/golang-hexagonal-architecture/scripts/verify_hexagonal.sh`).
   - Run verification scripts before finalizing architectural changes.

---

## Skill Directory & Quick Lookup

- **Architecture & DDD**:
  - `golang-hexagonal-architecture`: Ports & Adapters, domain isolation, boundary checks.
  - `golang-unit-of-work`: Atomic operations across multiple repositories.
  - `golang-transactional-outbox`: At-least-once asynchronous event publishing.
  - `golang-core-service`: Core domain invariants and capability boundaries.
  - `golang-bff`: Backend-for-Frontend API orchestration.
- **APIs & Web**:
  - `golang-rest-api-design`: REST endpoints, Gorilla Mux routes, envelope responses.
  - `golang-swagger`: Swaggo doc annotations and OpenAPI generation.
  - `golang-validator`: Struct validation rules via `validator/v10`.
  - `golang-idempotent`: Idempotency keys, replay prevention, and deduplication.
- **Concurrency & Reliability**:
  - `golang-concurrency`: Goroutines, channels, worker pools, errgroup, race avoidance.
  - `golang-error-handling`: Error wrapping (`%w`), custom error types, sentinel checks.
  - `golang-apperror-logging`: Log-Once pattern with `slog` and cross-layer errors.
  - `golang-observability`: OpenTelemetry traces, Prometheus metrics, structured logs.
  - `golang-troubleshooting`: Memory profiling (pprof), deadlocks, and race diagnosis.
  - `golang-performance`: CPU/memory profiling, cgroups, `automemlimit`, alloc optimizations.
  - `golang-consumer`: Resilient Kafka/RabbitMQ consumers, DLQs, worker shutdowns.
  - `golang-batch-job`: Bounded concurrency batch pipelines with safe retries.
- **Databases & Caching**:
  - `golang-sql`: Relational database access, transactions, and cursor pagination.
  - `golang-postgres`: PostgreSQL access using `pgx` and connection pools.
  - `golang-mysql`: MySQL access with connection tuning and driver options.
  - `golang-migrations`: Zero-downtime, reversible schema migrations.
  - `golang-cache`: Cache-aside patterns, TTL invalidation, stampede defense.
  - `golang-redis`: Redis v9 keys, locks, streams, pub/sub.
  - `golang-valkey`, `golang-valkey-cluster`, `golang-valkey-pubsub`: Valkey operations.
- **Testing & Quality**:
  - `golang-unit-testing`: Fast, deterministic table-driven unit tests.
  - `golang-mockery`: Mockery v3 interface test doubles and expectations.
  - `golang-integration-testing`: Testcontainers-go integration testing.
  - `golang-lint`: `golangci-lint` and `depguard` boundary rules.
- **Security & Principles**:
  - `golang-security`: Secure defaults, dependency vulnerability scanning (`govulncheck`).
  - `sensitive-data`: PII classification, redaction, telemetry sanitization.
  - `golang-crypto`: Encryption, HMAC, hashing, and password validation.
  - `software-principles`: SOLID, DRY, KISS, YAGNI, Law of Demeter.
  - `twelve-factor`: 12-Factor App design and deployment best practices.
  - `conventional-commits`: Conventional Commit format (`feat:`, `fix:`, `refactor:`).

---

## Coding & Commit Conventions

- Follow **Conventional Commits** format for all git commits.
- Ensure Hexagonal boundaries are respected: `domain/` contains pure Go business logic and zero infrastructure dependencies.
