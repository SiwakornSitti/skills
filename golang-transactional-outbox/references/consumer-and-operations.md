# Consumers and Operations

## Consumer idempotency

The outbox relay provides at-least-once delivery, so consumers must safely
handle duplicate events:

```go
type Consumer struct {
	uc domain.UseCase
}

func (c *Consumer) HandleAccountCreated(ctx context.Context, msg []byte) error {
	var evt AccountCreatedEvent
	if err := json.Unmarshal(msg, &evt); err != nil {
		return fmt.Errorf("unmarshal event: %w", err)
	}

	return c.uc.HandleAccountOpened(ctx, evt.AccountID, evt.UserID)
}
```

Use a stable event identifier or business key for deduplication, and make the
consumer's side effects repeat-safe. Malformed payloads need an explicit
failure or dead-letter policy; they must not silently succeed.

## Operational rules

- Index pending entries by delivery state and creation time.
- Add cleanup or retention for delivered entries, for example entries older
  than the agreed retention period.
- Keep publication outside the local database transaction.
- Prevent poison-pill events from blocking all later entries; track failures,
  alert, and use a durable dead-letter or quarantine policy when required.
- Emit bounded metrics and structured logs for fetch, publish, mark-delivered,
  retry, and skipped-entry outcomes.

The outbox provides durable handoff from local state to relay intent. It does
not provide exactly-once publication, global ordering, distributed atomicity,
or successful downstream processing.
