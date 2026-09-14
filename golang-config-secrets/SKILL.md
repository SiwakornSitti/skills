---
name: golang-config-secrets
description: Load, validate, and operate Go service configuration and secrets safely.
license: MIT
compatibility: Requires Go 1.22+.
metadata:
  version: "1.0"
  tags: [go, config, secrets, environment]
---

# Go Configuration and Secrets

Use this skill when adding configuration, environment variables, credentials,
or secret-backed clients. Read the reference matching the concern:

- [config-model.md](references/config-model.md) — typed configuration ownership and immutability.
- [sources-and-precedence.md](references/sources-and-precedence.md) — environment, `.env`, defaults, and examples.
- [secrets-and-redaction.md](references/secrets-and-redaction.md) — secret handling and diagnostic redaction.
- [validation-and-startup.md](references/validation-and-startup.md) — required values and client startup checks.
- [json-config.md](references/json-config.md) — typed JSON objects and environment overlays.
- [testing-and-lifecycle.md](references/testing-and-lifecycle.md) — safe configuration tests and reload boundaries.

Completion check: read every reference matching the change and apply its implementation and verification requirements.

## Related skills

- [golang-security](../golang-security/SKILL.md)
- [sensitive-data](../sensitive-data/SKILL.md)
- [golang-docker](../golang-docker/SKILL.md)
- [golang-redis](../golang-redis/SKILL.md)
- [golang-valkey](../golang-valkey/SKILL.md)
