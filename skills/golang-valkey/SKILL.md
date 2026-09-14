---
name: golang-valkey
description: Add or change Valkey access in Go using the official valkey-go client, including caching, commands, transactions, and distributed coordination.
license: MIT
compatibility: Requires Go 1.27+ and github.com/valkey-io/valkey-go. This repository currently uses Redis via go-redis; adding Valkey requires an explicit dependency and deployment decision.
metadata:
  version: "1.0"
  tags: [go, valkey, cache, distributed-systems, redis-compatible]
---

# Go Valkey

Read the matching reference before changing this skill:

- [overview.md](references/overview.md) — shared guidance.
- [adoption-boundary.md](references/adoption-boundary.md) — Adoption boundary.
- [client-and-context.md](references/client-and-context.md) — Client and context.
- [compatibility-and-data-contracts.md](references/compatibility-and-data-contracts.md) — Compatibility and data contracts.
- [reliability-and-safety.md](references/reliability-and-safety.md) — Reliability and safety.
- [verification.md](references/verification.md) — Verification.

Completion check: read every reference matching the change and apply its implementation and verification requirements.

## Related skills

- [golang-redis](../golang-redis/SKILL.md) — Redis-compatible client comparison.
- [golang-cache](../golang-cache/SKILL.md) — cache-aside, TTL, and invalidation policy.
- [golang-integration-testing](../golang-integration-testing/SKILL.md) — real Valkey compatibility tests.
- [golang-config-secrets](../golang-config-secrets/SKILL.md) — endpoint, TLS, and secret configuration.
- [golang-observability](../golang-observability/SKILL.md) — bounded cache and dependency telemetry.
- [golang-valkey-pubsub](../golang-valkey-pubsub/SKILL.md) — advanced ephemeral pub/sub delivery.
- [golang-valkey-cluster](../golang-valkey-cluster/SKILL.md) — cluster routing and topology behavior.
