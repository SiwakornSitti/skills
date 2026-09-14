# KISS

Aim for the simplest solution that works and remains clear at the next
maintenance point. Prefer a direct function, struct, `switch`, map, or
standard-library type over a factory, registry, framework, or abstraction with
only one real use.

## Decision order

1. Keep the existing code if it already meets the requirement.
2. Prefer deletion or a direct local change.
3. Reuse an existing repository pattern or standard-library feature.
4. Add a named abstraction only when it removes real duplication or isolates a
   demonstrated variation.

The simplest design still validates untrusted input, handles errors, preserves
atomicity, and enforces security requirements. “Simple” means fewer concepts,
not fewer safeguards.

## Example

Use a direct lookup when the application has one fixed mapping instead of
introducing a configurable provider:

```text
statusText = {200: "ok", 404: "not found"}
message = statusText[statusCode]
```

Use a `switch` when each case has distinct behavior. Use a map when the cases
are data. Prefer built-in platform features before adding a dependency. Do not
hide either behind a strategy interface until a second real implementation or
independent lifecycle justifies it.

## Complexity signals

Question the design when it introduces:

- A factory that constructs one concrete type.
- A registry with one registered item.
- Configuration for a value that never varies by environment or request.
- Multiple forwarding methods that add no policy.
- An abstraction whose name is more general than its only caller.

Remove incidental machinery only after checking public contracts and existing
callers. A short function with explicit failure handling is usually easier to
maintain than a framework callback or option-heavy constructor.
