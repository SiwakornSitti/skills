# Applying software principles

Use principles as decision tests, not as reasons to add structure. Start with
the behavior, coupling, or change that needs attention and choose the smallest
principle that explains the fix.

Begin with ownership, concrete types, direct functions, standard-library
features, and clear boundaries. Keep domain rules out of generic utility
packages and keep infrastructure details at adapter or wiring boundaries.

## Priority

Apply these principles only after preserving:

1. Correctness and data integrity.
2. Security, privacy, and accessibility requirements.
3. The user's explicit behavior, API, persistence, and wire contracts.
4. Existing ownership and architectural boundaries.

When principles conflict, prefer the simpler design that keeps the contract
and makes the next likely change local. A principle is not a reason to rename
public fields, add an abstraction, or change a boundary without a concrete
need.

## Choosing a principle

- Repeated knowledge or behavior: read [DRY](dry.md).
- Mixed responsibilities or an unstable boundary: read [SOLID](solid.md).
- Unnecessary machinery or nesting: read [KISS](kiss.md).
- Hypothetical flexibility: read [YAGNI](yagni.md).
- A collaborator reaches through nested objects: read [Law of Demeter](law-of-demeter.md).
- Business decisions are mixed with effects: read [Functional Core, Imperative Shell](functional-core-imperative-shell.md).

Several principles may apply, but do not perform a broad cleanup when one
focused change solves the reported problem.

## Example

Before adding a generic repository interface, check whether two real call sites
share an algorithm. If only one domain uses it, keep the concrete repository
and defer the abstraction. If the repository hides a database dependency from a
use case, a small consumer-owned port may be justified by Dependency Inversion.

Likewise, prefer a direct function for one pure calculation and a concrete type
for one adapter. Add an interface only at a real substitution, testing seam, or
independently changing boundary.

## Completion check

Describe the concrete problem the principle addresses, keep the diff focused,
and leave one focused test or runnable check for non-trivial behavior changes.
