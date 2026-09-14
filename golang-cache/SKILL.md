---
name: golang-cache
description: Add or change application caching in this Go service, including cache-aside reads, TTLs, invalidation, and cache verification.
license: MIT
compatibility: Applies to cache implementations behind this repository's cache adapters.
metadata:
  version: "1.0"
  tags: [go, cache, performance]
---

# Go Cache

Read the topic reference that matches the requested cache change:

- [strategy.md](references/strategy.md) — deciding whether and how to cache.
- [freshness-invalidation.md](references/freshness-invalidation.md) — TTL, consistency, and write invalidation.
- [load-failure-security.md](references/load-failure-security.md) — capacity, outages, stampedes, and sensitive data.
- [verification.md](references/verification.md) — tests and operational signals.

Completion check: read every reference matching the change and apply its implementation and verification requirements.

## Related skills

- [golang-redis](../golang-redis/SKILL.md)
- [golang-valkey](../golang-valkey/SKILL.md)
- [golang-integration-testing](../golang-integration-testing/SKILL.md)
- [golang-observability](../golang-observability/SKILL.md)
