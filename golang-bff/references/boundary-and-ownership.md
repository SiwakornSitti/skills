# BFF boundary and ownership

A BFF is a client-facing composition boundary. It adapts one client’s needs to stable core-service contracts; it is not a replacement domain service.

## BFF owns

- client-specific endpoints, response aggregation, and presentation DTOs;
- choosing which core services to call for a view;
- trusted request context propagation and client-facing error translation;
- time budgets, fan-out limits, and the policy for required versus optional data;
- read shaping such as sorting, labeling, and combining already-authorized data.

## Core services own

- canonical business rules, invariants, authorization decisions about domain actions, and state transitions;
- writes and side effects, including transactions and idempotency records;
- persistence schema and repository access;
- domain errors and data ownership;
- workflows that must be consistent across clients.

Keep each BFF endpoint scoped to one client view or workflow. If the BFF starts deciding a business invariant, writing another service’s database, or duplicating a workflow used by multiple clients, move that behavior behind a core-service use case or API.

The BFF must call core services through outbound ports and adapters. Do not import another context’s repositories, domain internals, generated persistence models, or private packages. Do not share a database to avoid an API call.

## Boundary test

Ask: “Would this rule still be required if a second client, batch job, or event consumer performed the operation?” If yes, it belongs in the core service. The BFF may decide how to present the result, not whether the domain operation is valid.
