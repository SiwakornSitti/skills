# Delivery contracts

Write down what the subscriber promises before choosing handler behavior.

## Semantics to define

- **Loss:** messages published while disconnected are missed unless another
  durable source is used for recovery.
- **Ordering:** define whether order matters per channel, key, publisher, or not
  at all. Do not claim global ordering without verifying the topology and
  client behavior.
- **Duplication:** make side-effecting handlers idempotent if reconnect or
  application retry can repeat work.
- **Payload:** version the message type and reject or safely ignore unknown
  versions according to the domain contract.
- **Failure:** decide whether malformed messages are logged and skipped,
  terminate the subscriber, or trigger an alert and state refresh.

## Handler boundary

The receive loop should do only transport work: receive, decode, attach
correlation information, and hand off. The handler owns domain validation and
side effects.

- Bound handler concurrency instead of starting an unbounded goroutine per
  message.
- Do not acknowledge a pub/sub message; pub/sub has no durable acknowledgement
  contract.
- Avoid blocking the receive loop on slow business work when the chosen client
  and delivery contract require continued reception. Use a bounded work queue
  and define overflow behavior.
- Log errors once at the inbound boundary with channel and message metadata,
  excluding secrets and sensitive payloads.

If processing must survive restart, replace pub/sub with a durable mechanism;
do not silently invent acknowledgements in application memory.
