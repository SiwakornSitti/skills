## Keys and values

- Use namespaced, versioned keys with a documented shape, such as account:v1:id:<id>.
- Centralize key construction so read, write, delete, and invalidation use exactly the same key.
- Bound key components and reject untrusted values that could create uncontrolled key growth.
- Serialize explicit DTOs or stable domain projections. Do not cache arbitrary structs, credentials, tokens, or data whose retention and exposure are not understood.
- Set a finite TTL for cache entries. A missing TTL on mutable data is usually a production memory and staleness bug.
