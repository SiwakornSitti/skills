# GitHub Copilot Instructions

This repository contains a comprehensive set of 43 skills for Go development, Hexagonal Architecture, testing, and cloud-native systems.

## Key Guidelines

1. **Architecture**:
   - Maintain strict separation of concerns following Hexagonal Architecture (Ports & Adapters).
   - Domain models and business logic must not depend on external frameworks, databases, or protocols.
   - Keep adapter implementations inside `inbound/` (HTTP, event handlers) and `outbound/` (SQL, Redis, external APIs).

2. **Error Handling & Logging**:
   - Always wrap errors with context using `fmt.Errorf("...: %w", err)`.
   - Practice the "Log-Once" rule: log errors at the edge (e.g. HTTP handler or consumer entrypoint), not at every internal layer.
   - Never log sensitive data (PII, credentials, access tokens).

3. **Concurrency & Safety**:
   - Always propagate `context.Context` and check `ctx.Err()`.
   - Prevent goroutine leaks by bounding worker pools and ensuring channels are closed or drained.
   - Guard shared state with proper mutexes or channels; test with `-race`.

4. **Skills Reference**:
   - Each skill directory `./skills/<skill-name>/` contains a `SKILL.md` file and a `references/` directory with specific implementation patterns.
