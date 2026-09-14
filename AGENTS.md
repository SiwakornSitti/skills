# AGENTS.md — Universal Agent Instructions

This repository is a curated library of **43 production-grade skills** for Go engineering, architectural design (Hexagonal / Ports & Adapters), security, testing, data handling, and software engineering principles.

This file serves as the configuration and behavior guide for autonomous AI coding agents, including **OpenAI Codex**, **Antigravity (agy)**, **Claude Code**, **Cursor**, **Copilot**, and other LLM agent systems.

---

## 1. Agent Operating Principles

1. **Progressive Disclosure**:
   - Do NOT load every skill or reference file into your context window at once.
   - Match the user's prompt to the relevant skill in the [Skill Catalog](#2-skill-catalog).
   - Read only the target skill's `SKILL.md` first.
   - Only load specific files under `references/`, `examples/`, or `scripts/` when required by the task.

2. **Skill Resolution Hierarchy**:
   - Skills can be accessed at:
     - Canonical path: `./skills/<skill-name>/SKILL.md`
     - Antigravity: `.agents/skills/<skill-name>/SKILL.md`
     - Claude Code: `.claude/skills/<skill-name>/SKILL.md`
   - When referencing scripts or helper tools within a skill, execute them relative to the skill path.

3. **Architectural Invariants**:
   - In Hexagonal Architecture projects, enforce domain purity: `domain/` must never import infrastructure, database drivers (`pgx`, `database/sql`), or HTTP packages (`net/http`, `gorilla/mux`).
   - Adapters belong in `inbound/` (HTTP, gRPC, consumers) and `outbound/` (repositories, clients, event publishers).
   - Module wiring and composition roots must reside exclusively in `module.go` or `cmd/`.

4. **Security & Data Privacy**:
   - Always check for sensitive data (PII, tokens, private keys) before logging or returning responses.
   - Use the `sensitive-data` skill whenever handling credentials or personal identifiers.

---

## 2. Skill Catalog

| Category | Skill | Trigger / Best For |
| :--- | :--- | :--- |
| **Architecture** | [`golang-hexagonal-architecture`](./skills/golang-hexagonal-architecture/SKILL.md) | Bounded contexts, ports & adapters, domain isolation, module wiring |
| | [`golang-unit-of-work`](./skills/golang-unit-of-work/SKILL.md) | Atomic multi-repository transactions within a bounded context |
| | [`golang-transactional-outbox`](./skills/golang-transactional-outbox/SKILL.md) | Reliable, event-driven async publishing across services |
| | [`golang-core-service`](./skills/golang-core-service/SKILL.md) | Business invariants, core state transitions, domain-owned capabilities |
| | [`golang-bff`](./skills/golang-bff/SKILL.md) | Backend-for-Frontend API aggregation and data shaping |
| **Clean Code & Idioms** | [`golang-idioms`](./skills/golang-idioms/SKILL.md) | Idiomatic Go naming, interface placement, error handling flow |
| | [`software-principles`](./skills/software-principles/SKILL.md) | SOLID, DRY, KISS, YAGNI, Law of Demeter, Functional Core |
| | [`twelve-factor`](./skills/twelve-factor/SKILL.md) | 12-Factor app principles (config, stateless processes, port binding) |
| | [`conventional-commits`](./skills/conventional-commits/SKILL.md) | Commit message formatting (`feat:`, `fix:`, scopes, breaking changes) |
| | [`golang-safety`](./skills/golang-safety/SKILL.md) | Panic prevention, nil checks, defensive copying, slice/map ownership |
| | [`golang-generics`](./skills/golang-generics/SKILL.md) | Clean, non-leaky generic utilities and data structures |
| | [`golang-modernize`](./skills/golang-modernize/SKILL.md) | Upgrading to modern Go versions, standard library idioms, deps |
| **APIs & Communication** | [`golang-rest-api-design`](./skills/golang-rest-api-design/SKILL.md) | REST design, Gorilla Mux routes, envelope patterns, pagination |
| | [`golang-swagger`](./skills/golang-swagger/SKILL.md) | Swaggo annotations and OpenAPI documentation generation |
| | [`golang-validator`](./skills/golang-validator/SKILL.md) | Request struct validation using `go-playground/validator/v10` |
| | [`golang-idempotent`](./skills/golang-idempotent/SKILL.md) | Idempotency keys, replay defense, safe HTTP retries |
| | [`golang-consumer`](./skills/golang-consumer/SKILL.md) | Event & message consumers (Kafka/RabbitMQ), dead-letter queues |
| | [`golang-batch-job`](./skills/golang-batch-job/SKILL.md) | Batch processing, bounded concurrency, backpressure, retries |
| **Databases & Storage** | [`golang-sql`](./skills/golang-sql/SKILL.md) | Driver-agnostic relational SQL, cursor pagination, transactions |
| | [`golang-postgres`](./skills/golang-postgres/SKILL.md) | PostgreSQL access via `pgx`, connection pools, binary protocol |
| | [`golang-mysql`](./skills/golang-mysql/SKILL.md) | MySQL access, connection timeouts, driver options |
| | [`golang-migrations`](./skills/golang-migrations/SKILL.md) | Reversible schema migrations, zero-downtime column migrations |
| **Caching & In-Memory** | [`golang-cache`](./skills/golang-cache/SKILL.md) | Application caching, cache-aside pattern, stampede prevention |
| | [`golang-redis`](./skills/golang-redis/SKILL.md) | Redis via `go-redis/v9` (streams, locks, pub/sub, caching) |
| | [`golang-valkey`](./skills/golang-valkey/SKILL.md) | Valkey access via official `valkey-go` client |
| | [`golang-valkey-cluster`](./skills/golang-valkey-cluster/SKILL.md) | Valkey Cluster hash-slot routing, multi-key constraints |
| | [`golang-valkey-pubsub`](./skills/golang-valkey-pubsub/SKILL.md) | Valkey pub/sub subscriber lifecycle and reconnections |
| **Reliability & Concurrency** | [`golang-concurrency`](./skills/golang-concurrency/SKILL.md) | Goroutines, channels, errgroup, worker pools, race detection |
| | [`golang-error-handling`](./skills/golang-error-handling/SKILL.md) | Error wrapping (`fmt.Errorf`), custom sentinel errors, unwrap |
| | [`golang-apperror-logging`](./skills/golang-apperror-logging/SKILL.md) | Log-Once pattern, structured slog, cross-boundary error translation |
| | [`golang-observability`](./skills/golang-observability/SKILL.md) | OpenTelemetry traces, Prometheus metrics, structured logging |
| | [`golang-troubleshooting`](./skills/golang-troubleshooting/SKILL.md) | Race conditions, memory leaks, pprof diagnostics, deadlocks |
| | [`golang-performance`](./skills/golang-performance/SKILL.md) | Benchmarks, allocs/op, cgroup memory limits (`automemlimit`) |
| **Testing & Quality** | [`golang-unit-testing`](./skills/golang-unit-testing/SKILL.md) | Unit tests, table-driven tests, subtests, test doubles |
| | [`golang-mockery`](./skills/golang-mockery/SKILL.md) | Mockery v3 generation for domain interfaces |
| | [`golang-integration-testing`](./skills/golang-integration-testing/SKILL.md) | Integration tests with Testcontainers-go / local Docker |
| | [`golang-lint`](./skills/golang-lint/SKILL.md) | `golangci-lint`, depguard architecture boundary enforcement |
| **Security & Infrastructure** | [`golang-security`](./skills/golang-security/SKILL.md) | Secure defaults, dependency audit (`govulncheck`), TLS |
| | [`sensitive-data`](./skills/sensitive-data/SKILL.md) | PII, redaction, credentials, token masking in logs/telemetry |
| | [`golang-crypto`](./skills/golang-crypto/SKILL.md) | Cryptography (AES-GCM, HMAC-SHA256, bcrypt, argon2id) |
| | [`golang-config-secrets`](./skills/golang-config-secrets/SKILL.md) | Environment configuration, secret management, validation |
| | [`golang-docker`](./skills/golang-docker/SKILL.md) | Minimal multi-stage distroless/scratch Go Docker containers |
| | [`golang-documentation`](./skills/golang-documentation/SKILL.md) | Go doc comments, package architecture documentation |

---

## 3. How Agents Should Apply Skills

When assisting users on coding tasks:
1. Identify if the task involves any domain covered by the catalog (e.g., adding a database migration, designing a REST handler, writing an integration test).
2. Consult the relevant skill directory and read its `SKILL.md`.
3. Check if verification scripts exist in `scripts/` (e.g. `scripts/verify_hexagonal.sh`) and run them after making code changes.
4. Verify tests pass and adhere to the architectural rules described in the skill before completing the task.
