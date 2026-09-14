# Pub/sub overview

Valkey pub/sub is an ephemeral fan-out transport. A published message is sent
to subscribers that are currently connected and subscribed; it is not retained
for later replay.

## Use pub/sub when

- Consumers need near-real-time notifications.
- Losing messages during subscriber downtime is acceptable.
- The source of truth remains in a database or another durable system.
- A reconnecting subscriber can refresh state after gaps.

## Do not use pub/sub when

- Every message must be processed.
- A consumer must resume from an offset.
- Backlog, acknowledgement, retry, or dead-letter behavior is required.
- The message itself is the only durable record of a business event.

Use a durable stream or queue for those requirements. Do not compensate for
missing durability by adding an application-side retry loop around publish.

## Design boundary

- Create the Valkey client once during startup.
- Let one long-lived component own each subscription and its cancellation.
- Keep publishing separate from subscription lifecycle where their scaling and
  failure behavior differ.
- Pass a small domain message or callback across the application boundary;
  avoid leaking client response objects into business logic.
- Treat a successful publish as accepted by Valkey, not proof that a consumer
  processed the message.
