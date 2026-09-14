# Routes

## Route design

- Register routes in the owning context's `RegisterRoutes` with Gorilla Mux and
  `net/http` method constants.
- Prefer plural resources and stable identifiers: `/accounts` and
  `/accounts/{id}`.
- Use nested paths only when the parent scopes the child collection, such as
  `/accounts/{accountID}/transactions`.
- Use action subresources for explicit state transitions that are not ordinary
  CRUD, such as `/loans/{id}/approve`.
- Keep routes unique across modules. A collision can silently select the first
  registered handler.
- Use path variables only for routing. Validate IDs and authorization in the
  handler or use case.
- Use query parameters for collection filters and pagination, and request
  bodies for commands. Keep mutable state out of paths.
- Preserve existing paths and fields unless the request explicitly changes the
  public contract.

Do not add a version prefix, envelope, authentication scheme, or content
negotiation rule unless the requested contract requires it.
