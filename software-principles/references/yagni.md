# YAGNI

Build only what is needed today. Defer hypothetical features, flexibility,
configuration, and extension points until a real requirement or second use
justifies them.

## Use evidence

An extension point is justified by one of these concrete signals:

- A current requirement has multiple supported variants.
- Two real callers need the same behavior with different implementations.
- A stable external boundary requires substitution for production, testing, or
  deployment.
- A known migration or compatibility contract requires the seam now.

“We may need it later” is not enough. Future code can add the abstraction with
better information about its shape.

## Keep present behavior direct

- Store only configuration the service currently reads and applies.
- Add fields when a consumer or persisted contract needs them, not for a
  guessed next version.
- Avoid unused interfaces, option-heavy constructors, plugin hooks, generic
  options, and feature flags.
- Do not generalize a one-off workflow before a second use exposes the shared
behavior.

Prefer a concrete constructor when there is one implementation. Add a
consumer-owned interface when a use case needs a real substitute, not just
because the concrete type has methods.

## Example

Keep configuration limited to the behavior the service currently supports:

```text
Config:
    timeout
```

Add retry strategies or plugin hooks when a concrete caller needs them, not in
anticipation of one. Keep required validation and compatibility handling even
when they serve only one current caller. Load and validate environment-backed
values at the application boundary; do not add configuration fields that no
code consumes.

## Review question

For each proposed capability, ask: “Which current requirement, caller, or
boundary fails without this?” If there is no concrete answer, delete it or
record it as a future task rather than implementing it now.
