# Lifecycle and restarts

- Propagate `context.Context` and stop claiming new work after cancellation.
- Let the current item finish within the shutdown grace period when safe; let
  the lease expire and reclaim the item when the worker stops first.
- Make startup, shutdown, and restart safe without losing durable claims or
  recording incomplete work as complete.
- Renew a lease only while the worker is actively processing the item and can
  still complete or release it.
