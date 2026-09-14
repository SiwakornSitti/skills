# Relay Worker

Run the relay as a background worker, typically in `cmd/consumer` or alongside
server startup. It polls pending entries, publishes them, and marks successful
publication as delivered.

```go
type Relay struct {
	store     Store
	publisher Publisher
	interval  time.Duration
	failures  map[string]int
}

func (r *Relay) Start(ctx context.Context) {
	ticker := time.NewTicker(r.interval)
	defer ticker.Stop()
	log := logger.FromContext(ctx)

	for {
		select {
		case <-ctx.Done():
			return
		case <-ticker.C:
			r.tick(ctx, log)
		}
	}
}

func (r *Relay) tick(ctx context.Context, log *slog.Logger) {
	tickCtx, cancel := context.WithTimeout(ctx, 30*time.Second)
	defer cancel()

	entries, err := r.store.FetchPending(tickCtx, 100)
	if err != nil {
		log.Error("fetch pending outbox entries", slog.String("error", err.Error()))
		return
	}

	for _, entry := range entries {
		if r.failures[entry.ID] >= 5 {
			log.Warn("skipping poison-pill outbox entry", slog.String("id", entry.ID))
			continue
		}

		if err := r.publisher.Publish(tickCtx, entry); err != nil {
			r.failures[entry.ID]++
			log.Error("publish outbox entry", slog.String("id", entry.ID), slog.String("error", err.Error()))
			continue
		}

		if err := r.store.MarkDelivered(tickCtx, entry.ID); err != nil {
			log.Error("mark outbox delivered", slog.String("id", entry.ID), slog.String("error", err.Error()))
			continue
		}

		delete(r.failures, entry.ID)
	}
}
```

A publish or delivery-mark failure leaves the entry pending for a later poll.
Design the publisher and consumers for at-least-once delivery: a crash after
publish and before `MarkDelivered` can publish the same entry again.

Bound each polling tick with a timeout, stop cleanly on context cancellation,
and make the polling interval and batch size operational settings. In-memory
failure counts reset on process restart; durable retry state is required when
retry history must survive restarts.
