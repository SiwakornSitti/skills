# Durable coordination

- Coordinate work with a durable queue, partition, or atomic database lease.
  Never rely on an in-memory offset or process-global lock.
- Make claims uniquely owned, leases expiring, and abandoned work reclaimable
  after worker failure.
- Persist progress atomically with the item result when they share a database.
  When they do not, define an explicit recovery or deduplication strategy.
- Keep coordination durable across process restarts and multiple worker
  instances.
