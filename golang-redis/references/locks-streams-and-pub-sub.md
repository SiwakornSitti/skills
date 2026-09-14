## Locks, streams, and pub/sub

- A Redis lock needs an owner token, a bounded lease, and release that deletes only the owner's lock. Do not unlock another worker's lease.
- Design lock renewal, process pauses, and expiry as failure cases; a lock is not proof that work completed.
- For streams or queues, make handlers idempotent, persist progress according to the delivery contract, and define retry/dead-letter behavior.
- Pub/sub is ephemeral delivery. Do not use it as a durable event log unless message loss is acceptable.
