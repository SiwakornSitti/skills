---
name: golang-redis
description: Add or change Redis clients, commands, caching, locks, streams, or pub/sub in Go using github.com/redis/go-redis/v9.
license: MIT
compatibility: Requires Go 1.27+ and github.com/redis/go-redis/v9. This repository currently uses v9.18.0.
metadata:
  version: "1.0"
  tags: [go, redis, go-redis, cache, distributed-systems]
---

# Go Redis

Read the matching reference before changing this skill:

- [overview.md](references/overview.md) — shared guidance.
- [client-lifecycle-and-configuration.md](references/client-lifecycle-and-configuration.md) — Client lifecycle and configuration.
- [keys-and-values.md](references/keys-and-values.md) — Keys and values.
- [command-and-error-behavior.md](references/command-and-error-behavior.md) — Command and error behavior.
- [caching.md](references/caching.md) — Caching.
- [locks-streams-and-pub-sub.md](references/locks-streams-and-pub-sub.md) — Locks, streams, and pub/sub.
- [verification.md](references/verification.md) — Verification.

Completion check: read every reference matching the change and apply its implementation and verification requirements.

## Related skills

- [golang-cache](../golang-cache/SKILL.md) — cache-aside, TTL, and invalidation policy.
- [golang-valkey](../golang-valkey/SKILL.md) — Valkey client selection and compatibility.
- [golang-integration-testing](../golang-integration-testing/SKILL.md) — real Redis verification.
- [golang-concurrency](../golang-concurrency/SKILL.md) — locks, workers, and cancellation.
- [golang-observability](../golang-observability/SKILL.md) — bounded cache and dependency telemetry.
