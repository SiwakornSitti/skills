# DRY

Remove duplicated knowledge or behavior when it has one clear source of
truth. Keep similar code separate when it changes for different reasons.

## What to share

- **Knowledge:** one business rule, field name, protocol value, or calculation
  should have one authoritative definition.
- **Behavior:** one algorithm with the same edge cases should not be copied
  into multiple callers.
- **Contracts:** shared request, response, event, or error semantics should be
  defined at the boundary that owns them.

Do not extract code merely because it looks alike. Similar code that belongs to
different domains often needs to diverge independently; forcing it together
creates a shared change hazard.

## Safe extraction

Before centralizing code, verify that the call sites have the same:

- Inputs, outputs, error behavior, and side effects.
- Ownership and lifecycle.
- Change reason and expected future direction.

Put the shared function or type near the owner of the rule. Keep domain rules
out of generic utility packages, and avoid helpers whose only purpose is to
save a few obvious lines.

## Example

Centralize one validation rule instead of copying it into every handler:

```text
validateCurrency(currency):
    if currency is not "THB" and currency is not "USD":
        return "unsupported currency"
    return valid
```

The validator should be the source of truth for the rule. Presentation-specific
messages can remain at the handler boundary if different consumers need
different wording. Do not duplicate the rule in request validation, domain
logic, and persistence mapping.

## Boundaries

- Share constants or types when they represent one owned protocol or domain
  contract; do not create a global utility package for unrelated helpers.
- Extract a function when it removes duplicated behavior and preserves the same
  error and mutation semantics at each call site.
- Keep similar handlers separate when their HTTP contracts or change reasons
  differ, even if their current code is textually alike.
- Do not add a generic abstraction just to make two small, readable functions
  look shared.

## Warning signs

- A change requires editing several copies of the same business rule.
- Two “generic” helpers have nearly identical names but different semantics.
- A shared helper has many flags or callbacks to accommodate unrelated users.

In the last case, split the helper or keep the implementations local instead
of building a second abstraction around the first one.
