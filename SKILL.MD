# Go Application Development Guidelines (Backend Development Guidelines)

Welcome to the central hub for Go application development standards. This repository of knowledge outlines the best practices, architectural patterns, and coding rules required to build scalable, maintainable, and secure Go applications in this project.

## 1. Guiding Principles

- **Clean Code:** Write code that is explicit, easy to read, understand, and maintain.
- **YAGNI (You Aren't Gonna Need It):** Do not add functionality until it is absolutely necessary. Keep solutions focused on current requirements.
- **DRY (Don't Repeat Yourself):** Avoid duplicating code. Consolidate logic into reusable functions, packages, or components to maintain a single source of truth.
- **Clean Architecture:** Strictly separate concerns to create a system that remains independent of external frameworks, UIs, and databases.
- **Idiomatic Go:** Embrace the established conventions of the Go community (simplicity, composition over inheritance, and robust error handling).
- **Security First:** Treat security as a primary concern at every layer—from input validation and secure token generation to sensitive data handling and continuous vulnerability scanning.

## 2. Architecture & Design

Establish a robust foundation by understanding how code is organized and how different domains interact.

- 🏗️ **[Project Structure & Business Logic](references/project_structure.md):** Navigate the standard "package by feature" layout, and learn the strict rules for separating `handler`, `service`, and `repository` layers.
- 🔄 **[Inter-Module Communication](references/inter_module_communication.md):** Discover safe patterns (Orchestrators, Interfaces, Shared Models) to prevent circular dependencies.

## 3. API & Web Server

Build high-performance, predictable, and self-documenting APIs.

- 🌐 **[HTTP RESTful API Design](references/http_restful.md):** Standards for resource naming, HTTP methods, and status codes.
- 🚦 **[Web Server Configuration](references/web_server.md):** Requirements for HTTP/2 Cleartext (h2c), timeouts, and strict graceful shutdown sequences to ensure zero downtime.
- 📖 **[API Specification](references/api_specification.md):** Requirements for OpenAPI 3.0 documentation using `swaggo/swag`.
- ⚡ **[JSON Parsing](references/json_parsing.md):** Guidelines for using high-performance JSON libraries like `bytedance/sonic`.

## 4. Data & Storage

Interact with databases and caches efficiently and safely.

- 🗄️ **[Database](references/database.md):** Rules for connection pooling, UUIDv7, SQL injection prevention, avoiding ORMs, and managing migrations.
- 🚀 **[Caching](references/caching.md):** Best practices for Redis, in-memory caching, eviction policies, and batch operations.
- ⚙️ **[Configuration Management](references/configuration.md):** The Twelve-Factor app principles, environment variables, failing fast, and `.env` handling.
- 📨 **[Kafka & Event Streaming](references/kafka.md):** Guidelines for using `IBM/sarama` for asynchronous, event-driven architecture and implementing robust, idempotent consumers.

## 5. Quality & Security

Ensure the application is robust, secure, and predictable.

- 🛡️ **[Security Guidelines](references/security.md):** Deep dive into authentication (PASETO/JWT), Argon2id password hashing, AES-256-GCM encryption, and web security headers.
- 🧪 **[Testing](references/testing.md):** Requirements for unit testing business logic, writing `testcontainers-go` powered integration tests, and contract testing for APIs.
- 🚨 **[Error Handling & Logging](references/error_handling.md):** The "handle once" rule, wrapping errors, and avoiding double logging.

## 6. Operations & Reliability

Keep the application running smoothly in production environments.

- 🐳 **[Docker & Containerization](references/docker.md):** Best practices for multi-stage builds, compiling static binaries (`CGO_ENABLED=0`), and running as a non-root user.
- ☸️ **[Kubernetes Readiness](references/kubernetes.md):** Requirements for health checks, resource limits, and graceful shutdowns to ensure smooth orchestration.
- �🔭 **[Observability](references/observability.md):** Standards for OpenTelemetry distributed tracing, LETS metrics, structured logging, and strict PII data redaction.


## 7. Coding Standards

Write code that looks and feels like standard Go.

- 📝 **[Go Idioms and Clean Code](references/go_idioms_clean_code.md):** Rules for naming conventions, interface sizing, concurrency (`context`), and formatting tools (`golangci-lint`).
- 📜 **[Commit Messages](references/commit_messages.md):** The Conventional Commits standard required for version history, semantic versioning, and changelogs.
- 🛠️ **[Make Commands](references/makefile.md):** Standardized targets (`make lint`, `make test`, `make migrate-up`) for local development and CI pipelines.
