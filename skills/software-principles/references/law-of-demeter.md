# Law of Demeter

Keep dependencies close to immediate collaborators. A function should talk to
objects it directly owns, receives, or is responsible for—not navigate through
several objects to reach an implementation detail.

## Prefer behavior over traversal

Avoid callers that know a nested structure:

```text
email = order.customer.profile.contact.email
```

Expose behavior at the owner that knows the structure:

```text
Order.customerEmail() = Order.customer.profile.contact.email

email = order.customerEmail()
```

The method is useful when the lookup rule belongs to `Order` or when the
structure may change. If it only renames a field and adds no ownership or
behavior, do not create a forwarding method just to shorten a line.

## Boundaries

- Pass the value or small port a function needs instead of a large object graph.
- Keep repository, HTTP, and domain traversal inside the layer that owns it.
- Prefer a domain method or query result that expresses intent over exposing
  nested mutable structs.
- Return immutable-by-convention values or copies when callers must not mutate
  collaborator state.

Not every dot is a violation. A short chain over stable value objects, a
standard-library call, or a local data transformation is usually clear. The
problem is coupling a caller to another object's internal structure and making
many callers change when that structure changes.

## Common violations

- A handler reaches through `result.data.customer.address` instead of asking a
  use case for the response value it owns.
- A use case calls `repository.find(...).owner().profile().email()` and knows
  persistence and domain traversal details.
- A package exposes nested mutable objects only because a caller wanted one
  field, coupling every caller to the storage shape.

Fix these by moving the lookup to the owning type, returning a purpose-shaped
  result, or narrowing the port. Do not fix them with a getter for every field.

## Review question

If the nested collaborator changes its representation, which callers break?
Move the knowledge to the owner of that representation only when doing so
reduces real coupling and keeps the resulting API clearer.
