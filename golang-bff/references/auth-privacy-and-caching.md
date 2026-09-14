# Auth, privacy, and caching

Authenticate the caller at the BFF boundary, then propagate only trusted identity, audience, scopes, and correlation context to core services. Never treat a client-supplied user ID, account ID, or header as proof of ownership. Let the owning core service enforce domain authorization.

Privacy rules:

- request and return the minimum data needed for the client view;
- never log access tokens, credentials, full financial/identity payloads, or raw upstream bodies;
- redact identifiers in logs and traces according to the shared sensitive-data and observability guidance;
- do not put personal or authorization-sensitive data in metrics labels;
- use safe, synthetic fixtures and verify error responses contain no upstream internals.

Cache only stable, authorized reads. Define the owner, key scope, TTL, stale behavior, invalidation trigger, and failure behavior before adding a cache. A personalized response must be keyed by the relevant authorization scope or must not be shared. Do not cache mutations, permission decisions beyond their approved lifetime, or responses containing secrets.

The BFF may combine data from several services, but it must not widen access by merging records without checking the owning service’s authorization result.
