# Schema and Store

## Database schema

Keep pending-event polling efficient with an index over undelivered entries:

```sql
CREATE TABLE IF NOT EXISTS outbox (
    id           VARCHAR(64) PRIMARY KEY,
    event_type   VARCHAR(128) NOT NULL,
    payload      BYTEA NOT NULL,
    created_at   TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    delivered_at TIMESTAMPTZ NULL
);

CREATE INDEX IF NOT EXISTS idx_outbox_pending
ON outbox (created_at ASC)
WHERE delivered_at IS NULL;
```

Use a stable identifier, explicit event type, opaque serialized payload, event
creation time, and nullable delivery time. Evolve the schema through versioned
migrations.

## Go ports

Keep storage and publication behind small ports:

```go
package outbox

import (
	"context"
	"time"
)

type Entry struct {
	ID          string
	EventType   string
	Payload     []byte
	CreatedAt   time.Time
	DeliveredAt *time.Time
}

type Store interface {
	Save(context.Context, *Entry) error
	FetchPending(context.Context, int) ([]*Entry, error)
	MarkDelivered(context.Context, string) error
}

type Publisher interface {
	Publish(context.Context, *Entry) error
}
```

The store owns persistence; the publisher owns broker interaction. Keep the
relay independent of either concrete database or broker client.
