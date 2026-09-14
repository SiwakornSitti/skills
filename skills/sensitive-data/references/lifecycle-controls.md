# Lifecycle Controls

- Minimize stored, cached, queued, exported, and backed-up data; define retention and deletion behavior instead of retaining by default.
- Keep secrets in approved secret managers. Use approved cryptographic controls for sensitive data at rest and in transit, including encryption, hashing, key handling, and token protection.
- Audit sensitive-data access and export with non-sensitive identifiers; protect audit records from becoming a second leak.
- Use opaque IDs across service and queue boundaries. Do not place raw sensitive values in URLs, cache keys, event names, or unnecessary message fields.

Serialization guards do not prevent access, storage, transmission, or deletion failures through another path. Enforce authorization at each boundary and verify retention and deletion behavior for every copy.
