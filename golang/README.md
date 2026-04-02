# Go Application Development Guidelines

Welcome to the central hub for Go application development standards. This repository contains the comprehensive guidelines, best practices, and architectural standards for building scalable, maintainable, and secure Go applications.

It is designed to be used as an **Agent Skill** (`SKILL.MD`) to provide context and rules for AI assistants (like Claude or GitHub Copilot) when writing, reviewing, or refactoring Go backend code in this project.

## 📚 What's Inside

The guidelines are divided into specific topics located in the `references/` directory:

### Architecture & Design

- **[Project Structure](references/project_structure.md)**: Standard "package by feature" layout and separation of concerns (Handler, Service, Repository).
- **[Inter-Module Communication](references/inter_module_communication.md)**: Safe patterns to prevent circular dependencies.

### API & Web Server

- **[HTTP RESTful API](references/http_restful.md)**: Resource naming, methods, and status codes.
- **[Web Server](references/web_server.md)**: Configuration for h2c, timeouts, and graceful shutdowns.
- **[API Specification](references/api_specification.md)**: OpenAPI 3.0 documentation with `swaggo/swag`.
- **[JSON Parsing](references/json_parsing.md)**: High-performance JSON parsing.

### Data & Storage

- **[Database](references/database.md)**: Connection pooling, UUIDv7, SQL injection prevention, and migrations.
- **[Caching](references/caching.md)**: Redis and in-memory caching best practices.
- **[Configuration](references/configuration.md)**: Environment variables and Twelve-Factor app principles.
- **[Kafka](references/kafka.md)**: Event streaming and asynchronous architecture.

### Quality & Security

- **[Security](references/security.md)**: Authentication (PASETO/JWT), hashing, encryption, and headers.
- **[Testing](references/testing.md)**: Unit and integration testing with `testcontainers-go`.
- **[Error Handling](references/error_handling.md)**: The "handle once" rule and proper error wrapping.

### Operations & Reliability

- **[Docker](references/docker.md)**: Multi-stage builds, static binaries, and non-root users.
- **[Kubernetes](references/kubernetes.md)**: Health checks and resource limits.
- **[Observability](references/observability.md)**: OpenTelemetry tracing, metrics, and structured logging.

### Coding Standards

- **[Go Idioms](references/go_idioms_clean_code.md)**: Naming conventions, concurrency, and linting.
- **[Commit Messages](references/commit_messages.md)**: Conventional Commits standard.
- **[Makefiles](references/makefile.md)**: Standardized commands for local dev and CI.

## 🤖 How to use as an Agent Skill

The `SKILL.MD` file in the root of this repository acts as the entry point for the AI agent. It utilizes the "progressive disclosure" pattern, allowing the agent to read the high-level overview and then dynamically fetch specific reference files from the `references/` directory only when needed for a specific task.
