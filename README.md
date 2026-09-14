# 🛠️ Modular Engineering Skills Catalog

[![Claude Code](https://img.shields.io/badge/Claude%20Code-Supported-7c3aed.svg)](https://docs.anthropic.com/en/docs/agents-and-tools/claude-code)
[![Antigravity (AGY)](https://img.shields.io/badge/Antigravity%20(AGY)-Supported-4285f4.svg)](https://github.com/google-deepmind)
[![OpenAI Codex](https://img.shields.io/badge/OpenAI%20Codex-Supported-10a37f.svg)](https://openai.com)
[![Cursor](https://img.shields.io/badge/Cursor-Supported-000000.svg)](https://cursor.com)
[![GitHub Copilot](https://img.shields.io/badge/GitHub%20Copilot-Supported-1f2328.svg)](https://github.com/features/copilot)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

A curated collection of **43 production-grade skills** for Go engineering, Hexagonal Architecture (Ports & Adapters), domain isolation, high-throughput concurrency, security, and cloud-native systems.

Designed for seamless cross-agent compatibility with:
- **Claude Code** (via `.claude/skills/` & `CLAUDE.md`)
- **Antigravity (AGY)** (via `.agents/skills/` & `GEMINI.md`)
- **OpenAI Codex / OpenAgent** (via `AGENTS.md`)
- **Cursor** (via `.cursorrules`)
- **GitHub Copilot** (via `.github/copilot-instructions.md`)

---

## ⚡ Quick Start & Installation

Use the universal [`install.sh`](./install.sh) script to mount or install skills globally or into specific repositories.

```bash
# Clone the repository
git clone git@github.com:SiwakornSitti/skills.git
cd skills

# 1. Install globally for both Antigravity (AGY) and Claude Code
./install.sh --all

# 2. Install globally for Antigravity only (~/.gemini/config/skills)
./install.sh --agy

# 3. Install globally for Claude Code only (~/.claude/skills)
./install.sh --claude

# 4. Mount skills into any project repository
./install.sh --project /path/to/your-go-project
```

---

## 🤖 Multi-Agent Compatibility

| Agent / Tool | Discovery Location | Config / Instructions File |
| :--- | :--- | :--- |
| **Claude Code** | `.claude/skills/<skill>/SKILL.md` | [`CLAUDE.md`](./CLAUDE.md) |
| **Antigravity (AGY)** | `.agents/skills/<skill>/SKILL.md` | [`GEMINI.md`](./GEMINI.md) |
| **OpenAI Codex / Agents** | `AGENTS.md`, `./<skill>/SKILL.md` | [`AGENTS.md`](./AGENTS.md) |
| **Cursor** | `.cursorrules`, `./<skill>/SKILL.md` | [`.cursorrules`](./.cursorrules) |
| **GitHub Copilot** | `.github/copilot-instructions.md` | [`.github/copilot-instructions.md`](./.github/copilot-instructions.md) |

---

## 📚 Skills Catalog (43 Skills)

### 🏛️ Architecture & Domain-Driven Design (DDD)
- **[`golang-hexagonal-architecture`](./golang-hexagonal-architecture/SKILL.md)**: Implement Hexagonal Architecture (Ports & Adapters) with Bounded Contexts, UseCases, domain isolation, and modular wiring.
- **[`golang-unit-of-work`](./golang-unit-of-work/SKILL.md)**: Database-agnostic Unit of Work when atomic writes span multiple repositories in a bounded context.
- **[`golang-transactional-outbox`](./golang-transactional-outbox/SKILL.md)**: Reliable, eventual-consistent asynchronous event publishing across bounded contexts.
- **[`golang-core-service`](./golang-core-service/SKILL.md)**: Core services owning business capabilities, invariants, and durable side effects behind explicit ports.
- **[`golang-bff`](./golang-bff/SKILL.md)**: Backend-for-Frontend API orchestration, safe data shaping, and partial failure handling.

### 🧩 Clean Code, Idioms & Software Principles
- **[`golang-idioms`](./golang-idioms/SKILL.md)**: Idiomatic Go naming, interface placement, context propagation, and pointer semantics.
- **[`software-principles`](./software-principles/SKILL.md)**: SOLID, DRY, KISS, YAGNI, Law of Demeter, and Functional Core / Imperative Shell.
- **[`twelve-factor`](./twelve-factor/SKILL.md)**: Twelve-Factor App principles (config, stateless processes, port binding, disposability).
- **[`conventional-commits`](./conventional-commits/SKILL.md)**: Conventional Commit message format and commit validation.
- **[`golang-safety`](./golang-safety/SKILL.md)**: Panic prevention, nil checks, defensive copying, slice/map ownership, and resource lifecycles.
- **[`golang-generics`](./golang-generics/SKILL.md)**: Type-safe shared generic operations without leaking abstractions.
- **[`golang-modernize`](./golang-modernize/SKILL.md)**: Modern Go version upgrades, standard library idioms, and dependency refreshes.

### 🌐 APIs, Networking & Web
- **[`golang-rest-api-design`](./golang-rest-api-design/SKILL.md)**: REST endpoints, Gorilla Mux routes, envelope responses, pagination, and error contracts.
- **[`golang-swagger`](./golang-swagger/SKILL.md)**: Swaggo doc annotations and OpenAPI documentation generation.
- **[`golang-validator`](./golang-validator/SKILL.md)**: Request validation using `github.com/go-playground/validator/v10`.
- **[`golang-idempotent`](./golang-idempotent/SKILL.md)**: Idempotency keys, replay prevention, and deduplication across handlers and workers.
- **[`golang-consumer`](./golang-consumer/SKILL.md)**: Resilient message consumers, at-least-once delivery, bounded concurrency, and DLQs.
- **[`golang-batch-job`](./golang-batch-job/SKILL.md)**: Batch processing with durable coordination, backpressure, retries, and safe restarts.

### 💾 Databases & Storage
- **[`golang-sql`](./golang-sql/SKILL.md)**: Driver-agnostic relational SQL, cursor pagination, transactions, and row mapping.
- **[`golang-postgres`](./golang-postgres/SKILL.md)**: PostgreSQL access with `pgx`, connection pools, and query optimization.
- **[`golang-mysql`](./golang-mysql/SKILL.md)**: MySQL access with `database/sql`, timeouts, and driver tuning.
- **[`golang-migrations`](./golang-migrations/SKILL.md)**: Reversible, production-safe schema migrations.

### ⚡ In-Memory & Caching
- **[`golang-cache`](./golang-cache/SKILL.md)**: Cache-aside reads, TTLs, invalidation, and stampede prevention.
- **[`golang-redis`](./golang-redis/SKILL.md)**: Redis operations via `github.com/redis/go-redis/v9` (streams, locks, pub/sub).
- **[`golang-valkey`](./golang-valkey/SKILL.md)**: Official `github.com/valkey-io/valkey-go` integration and safety.
- **[`golang-valkey-cluster`](./golang-valkey-cluster/SKILL.md)**: Valkey Cluster hash-slot routing, key tags, and topology refresh.
- **[`golang-valkey-pubsub`](./golang-valkey-pubsub/SKILL.md)**: Valkey pub/sub subscriber lifecycle and reconnect semantics.

### ⏱️ Concurrency, Reliability & Observability
- **[`golang-concurrency`](./golang-concurrency/SKILL.md)**: Goroutines, channels, worker pools, errgroup, and race avoidance.
- **[`golang-error-handling`](./golang-error-handling/SKILL.md)**: Error wrapping, custom sentinel errors, and unwrapping.
- **[`golang-apperror-logging`](./golang-apperror-logging/SKILL.md)**: Log-Once pattern with `slog` and cross-layer boundary translation.
- **[`golang-observability`](./golang-observability/SKILL.md)**: Structured logging, Prometheus metrics, and OpenTelemetry tracing.
- **[`golang-troubleshooting`](./golang-troubleshooting/SKILL.md)**: Reproduction workflows, pprof profiles, deadlocks, and race condition debugging.
- **[`golang-performance`](./golang-performance/SKILL.md)**: Benchmarking, memory allocations, runtime GC, and cgroup limits (`automemlimit`).

### 🧪 Testing & Code Quality
- **[`golang-unit-testing`](./golang-unit-testing/SKILL.md)**: Isolated unit tests, table-driven tests, and subtests.
- **[`golang-mockery`](./golang-mockery/SKILL.md)**: Mockery v3 interface double generation and Testify expectations.
- **[`golang-integration-testing`](./golang-integration-testing/SKILL.md)**: Integration tests with Testcontainers-go and local Docker fallback.
- **[`golang-lint`](./golang-lint/SKILL.md)**: `golangci-lint` and `depguard` boundary enforcement.

### 🛡️ Security, Data Privacy & Operations
- **[`golang-security`](./golang-security/SKILL.md)**: Secure defaults, vulnerability scanning (`govulncheck`), and TLS configurations.
- **[`sensitive-data`](./sensitive-data/SKILL.md)**: PII, credentials, token redaction in telemetry and logs.
- **[`golang-crypto`](./golang-crypto/SKILL.md)**: Secure cryptography (AES-GCM, HMAC, bcrypt, key rotation).
- **[`golang-config-secrets`](./golang-config-secrets/SKILL.md)**: Environment configuration, secret handling, and validation.
- **[`golang-docker`](./golang-docker/SKILL.md)**: Multi-stage Docker builds, dependency caching, and minimal runtime images.
- **[`golang-documentation`](./golang-documentation/SKILL.md)**: Standard Go doc comments and architecture references.

---

## 📁 Repository Structure

```text
skills/
├── .agents/skills/      # Symlinks for Antigravity (AGY) workspace discovery
├── .claude/skills/      # Symlinks for Claude Code workspace discovery
├── .cursorrules         # Configuration and directives for Cursor IDE
├── .github/
│   └── copilot-instructions.md  # Configuration for GitHub Copilot
├── AGENTS.md            # Universal agent standard (Codex, AGY, OpenAgent)
├── CLAUDE.md            # Claude Code instructions
├── GEMINI.md            # Antigravity instructions
├── install.sh           # Universal installer script
├── README.md            # Repository overview & documentation
└── <skill-name>/        # Individual skill packages
    ├── SKILL.md         # Skill definition & frontmatter
    ├── evals/           # Verification evaluations
    ├── references/      # Deep-dive documentation & patterns
    ├── examples/        # Template implementations
    └── scripts/         # Automated validation scripts
```

---

## 📄 License

[MIT](LICENSE)
