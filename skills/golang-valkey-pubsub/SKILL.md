---
name: golang-valkey-pubsub
description: Design and implement Valkey pub/sub in Go with valkey-go, including subscriber lifecycle, reconnect and resubscribe behavior, lossy delivery, and verification.
license: MIT
compatibility: Requires Go 1.27+ and github.com/valkey-io/valkey-go.
metadata:
  version: "1.0"
  tags: [go, valkey, pubsub, messaging, reliability]
---

# Go Valkey pub/sub

Use this skill when a Go service needs Valkey's ephemeral publish/subscribe
transport. Read only the references matching the change:

- [overview.md](references/overview.md) — decide whether ephemeral pub/sub fits.
- [lifecycle-and-reconnect.md](references/lifecycle-and-reconnect.md) — own subscriptions and recover them safely.
- [delivery-contracts.md](references/delivery-contracts.md) — define loss, ordering, duplication, and handler behavior.
- [verification.md](references/verification.md) — verify behavior against real Valkey.

Keep pub/sub behind an application port when the rest of the service should not
depend on Valkey-specific types. Do not use pub/sub as a durable queue or event
log. For durable delivery, use a stream or message-consumer design instead.

Completion check: preserve cancellation and shutdown behavior, define the
delivery contract, and leave focused tests plus a real Valkey compatibility
test for non-trivial changes.

## Related skills

- [golang-valkey](../golang-valkey/SKILL.md) — client adoption and shared safety boundaries.
- [golang-consumer](../golang-consumer/SKILL.md) — durable consumer processing patterns.
- [golang-observability](../golang-observability/SKILL.md) — bounded dependency telemetry.
