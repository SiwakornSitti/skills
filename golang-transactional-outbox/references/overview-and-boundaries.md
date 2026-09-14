# Overview and Boundaries

## The dual-write problem

When a business operation must both mutate database state and publish an event:

- If the database write succeeds but the network or broker fails, downstream
  systems miss the event.
- If the broker publish succeeds but the database transaction rolls back,
  downstream systems process phantom data.

The Transactional Outbox pattern solves this by:

1. Inserting state changes and the domain event into PostgreSQL in the same
   atomic transaction.
2. Running an asynchronous Relay Worker that polls pending events, publishes
   them to the message broker, and marks them delivered.
3. Processing inbound events with idempotent Consumer Adapters.

```text
┌────────────────────────────────────────────────────────┐
│ PostgreSQL (Single Atomic Transaction)                │
│ ┌───────────────────────┐   ┌────────────────────────┐ │
│ │ Business Tables       │   │ Outbox Table           │ │
│ │ (e.g. accounts, cards)│   │ (pending events)       │ │
│ └───────────────────────┘   └───────────┬────────────┘ │
└─────────────────────────────────────────┼──────────────┘
                                          │ Polls pending
                              ┌───────────▼────────────┐
                              │ Outbox Relay Worker    │
                              └───────────┬────────────┘
                                          │ Publishes event
                              ┌───────────▼────────────┐
                              │ Message Broker         │
                              │ (Kafka / RabbitMQ)     │
                              └───────────┬────────────┘
                                          │ Consumes event
                              ┌───────────▼────────────┐
                              │ Inbound Consumer       │
                              │ (internal/<ctx>/consumer)
                              └────────────────────────┘
```

The database transaction guarantees local atomicity and durable event intent;
it does not guarantee broker delivery or consumer success.
