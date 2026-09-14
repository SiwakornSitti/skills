# Subscriber lifecycle and reconnect

Subscriptions are long-lived operations, not request-scoped commands. The
subscriber must have an explicit owner, context, shutdown path, and recovery
policy.

## Startup

- Construct the shared client during application startup.
- Start the subscriber with a context that is cancelled during graceful
  shutdown.
- Subscribe to the configured channels once and wait for the subscription to
  become active according to the pinned `valkey-go` API.
- Do not create a client or subscription for every HTTP request or published
  message.

## Reconnect

When the connection or server becomes unavailable:

1. Stop or abandon the failed receive loop according to the client contract.
2. Apply bounded backoff with cancellation; do not spin.
3. Reconnect using the shared client or its supported subscription mechanism.
4. Resubscribe to the complete configured channel set.
5. Record the gap and trigger state refresh when consumers need current state.

Do not assume messages published during the gap can be replayed. Do not retry
publishes blindly when repeating the message could cause an external side
effect.

## Shutdown

- Cancel the subscription context before closing the client.
- Stop handler workers and wait for in-flight work within the shutdown budget.
- Return context cancellation as normal shutdown, not as an application error.
- Close the client exactly once at its owning lifecycle boundary.

Keep reconnect, resubscribe, and handler concurrency bounded. Add a
`ponytail:` comment when a deliberately global subscription lock is used and
name the upgrade path if measured throughput later requires per-channel state.
