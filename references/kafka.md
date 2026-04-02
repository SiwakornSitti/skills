# Kafka & Event Streaming

This document outlines the best practices for implementing asynchronous event streaming using Apache Kafka and the `IBM/sarama` (formerly `Shopify/sarama`) Go client.

## 1. General Principles

- **Event-Driven Architecture:** Use Kafka for decoupled, asynchronous inter-module communication (as outlined in the Inter-Module Communication guide).
- **Library Choice:** Use `github.com/IBM/sarama` for full-featured Kafka integration.
- **Idempotency:** Because Kafka guarantees "at-least-once" delivery by default, all consumer logic **must** be idempotent. Processing the exact same message twice must yield the same system state as processing it once.

## 2. Consumer Implementation

- **Consumer Groups:** Always use Consumer Groups (`sarama.ConsumerGroup`) rather than standalone consumers to ensure scalability, fault tolerance, and automatic partition rebalancing.
- **Message Acknowledgment:** Only mark a message as processed (`session.MarkMessage`) *after* the business logic has successfully completed and state is persisted. Never acknowledge early.
- **Graceful Shutdown:** The Kafka consumer loop must listen for `context.Cancel` or OS signals and cleanly close the `sarama.ConsumerGroup` to release partitions immediately, avoiding rebalancing delays for other consumers.

## 3. Error Handling & Retries

- **Poison Pills:** Implement a Dead Letter Queue (DLQ) strategy. If a message consistently fails to process due to a validation or schema error (a "poison pill"), log the error, send the message to a DLQ topic, and acknowledge the original message to prevent the consumer from getting stuck in an infinite retry loop.
- **Transient Errors:** For transient errors (e.g., database temporarily down), rely on a backoff retry mechanism before ultimately failing or sending to a DLQ.

## 4. Producer Implementation

- **Sync vs Async:** 
  - Use `sarama.SyncProducer` when you *must* guarantee the message is written to Kafka before responding to the user (e.g., critical financial transactions).
  - Use `sarama.AsyncProducer` for high-throughput, non-critical events (e.g., logging, click-stream tracking), but ensure you handle the `Successes` and `Errors` channels to prevent memory leaks.
- **Message Keys:** Use meaningful message keys (e.g., `user_id` or `account_id`) to ensure that related events are always routed to the same partition, preserving strict ordering.
