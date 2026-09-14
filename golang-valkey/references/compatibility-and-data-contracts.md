## Compatibility and data contracts

- Use namespaced, versioned keys, finite TTLs, and centralized key builders such as account:v1:id:<id>.
- Treat missing values according to the operation: a normal cache miss is different from missing required state.
- Keep values compatible with the chosen serializer and avoid changing wire formats during a client migration.
- Verify every command, transaction, script, stream, pub/sub, or lock feature against the deployed Valkey version; protocol compatibility does not guarantee identical operational behavior.
- Do not depend on undocumented server behavior or client-specific retry semantics.
