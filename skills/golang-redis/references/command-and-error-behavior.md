## Command and error behavior

- Treat redis.Nil as a cache miss only where the operation defines a missing value as normal. Return it as a domain or application error for required data.
- Wrap operational errors with the operation and key namespace, but do not log them in the adapter when the inbound boundary owns logging.
- Use Set with its TTL for ordinary cache writes. Use SetArgs with Mode NX only when create-if-absent semantics are required.
- Prefer atomic Redis commands or transactions for coupled state changes. A client-side read/modify/write sequence is not atomic.
- Use pipelining for independent batches when round trips are measurable; do not pipeline unrelated operations merely to reduce line count.
- Use Lua scripts only when a small atomic operation cannot be expressed with existing commands, and test the script against a real Redis server.
