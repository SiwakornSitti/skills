---
name: golang-valkey-cluster
description: Design and implement Valkey Cluster access in Go with valkey-go, including hash-slot routing, key tags, topology refresh, MOVED and ASK handling, and multi-key operation limits.
license: MIT
compatibility: Requires Go 1.27+ and github.com/valkey-io/valkey-go, plus a real Valkey Cluster for compatibility verification.
metadata:
  version: "1.0"
  tags: [go, valkey, cluster, topology, distributed-systems]
---

# Go Valkey Cluster

Use this skill when a Go service targets Valkey Cluster or must become safe for
cluster routing. Read only the references matching the change:

- [overview.md](references/overview.md) — establish cluster boundaries and assumptions.
- [keys-and-routing.md](references/keys-and-routing.md) — design slot-safe keys and commands.
- [topology-and-multi-key-operations.md](references/topology-and-multi-key-operations.md) — handle topology changes and cross-slot limits.
- [verification.md](references/verification.md) — test against a real cluster.

Keep cluster-specific behavior behind an application port when domain code
does not need it. Do not include provider-specific provisioning or managed
service setup; configure the cluster endpoint and security through the service
configuration skill.

Completion check: identify key-slot assumptions, preserve context and retry
safety, and leave focused tests plus real cluster compatibility tests for
non-trivial changes.

## Related skills

- [golang-valkey](../golang-valkey/SKILL.md) — client adoption and shared safety boundaries.
- [golang-cache](../golang-cache/SKILL.md) — cache keys, TTL, and invalidation policy.
- [golang-config-secrets](../golang-config-secrets/SKILL.md) — endpoint, TLS, and secret configuration.
- [golang-integration-testing](../golang-integration-testing/SKILL.md) — real service compatibility tests.
