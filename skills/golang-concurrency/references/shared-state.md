# Shared state

- Use a mutex only for shared mutable state. Keep mutable state and its lock
  together.
- Prefer ownership transfer through channels when one goroutine can own the
  state instead of sharing it.
- Keep critical sections small and never hold a lock across blocking I/O or an
  unrelated callback.
- Run the race detector when changing shared state or synchronization.
