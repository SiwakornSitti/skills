# SOLID

Use SOLID as a set of design questions, not a requirement to create more
types. Start with the concrete coupling or change that is causing trouble;
apply only the principle that addresses it.

## Single Responsibility

A type or function should have one cohesive reason to change. “One
responsibility” does not mean one method: keep operations together when they
share the same domain decision, data, and lifecycle.

- Separate policy from unrelated effects such as email, persistence, or
  formatting when those concerns change independently.
- Keep orchestration in the service and move a substantial, independently
  testable decision into a domain function.
- Do not split every small function into its own type merely to achieve a
  smaller file.

## Open/Closed

Allow a real, recurring variation to be added without rewriting stable policy.
Put the seam at the point where the variation actually occurs.

- Prefer a small function, map, or `switch` for a small fixed set of cases.
- Introduce an interface or strategy when there are multiple real
  implementations, or an implementation must change independently.
- Do not add plugin registries, factories, or configuration for hypothetical
  future behavior.

## Liskov Substitution

An implementation must honor the behavioral contract of the abstraction it
replaces. Callers should not need type checks or special cases to use it.

- Preserve input and output expectations, error meaning, side-effect rules,
  and cancellation behavior.
- Do not implement an interface by returning surprising zero values, weakening
  validation, strengthening preconditions, or silently ignoring operations.
- If implementations need materially different contracts, use separate ports
  or model the difference explicitly instead of forcing one abstraction.

## Interface Segregation

Consumers should depend on focused interfaces containing only the operations
they use.

- Define interfaces at the consuming boundary or as small domain ports.
- Prefer one-role interfaces such as `FindByID` or `Publish` over a combined
  repository with unrelated read, write, and administrative methods.
- Keep concrete types easy to use directly; an interface with one
  implementation is justified only by a real boundary, substitution, or
  isolated test seam.

## Dependency Inversion

High-level policy should not depend directly on low-level infrastructure
details. Both should follow a stable contract owned by the policy boundary.

- Keep domain and use-case code independent of database, HTTP, queue, clock,
  and filesystem packages where those are replaceable details.
- Pass dependencies into constructors or functions; wire concrete adapters at
  the application boundary.
- Do not create an interface merely to hide a concrete dependency that has no
  meaningful variation or testing boundary.

```text
interface Clock:
    now() -> timestamp

expiry(now, ttl) = now + ttl
```

The `Clock` seam is useful when production time and deterministic test time
are real substitutions. A direct `time.Now()` call is simpler when no such
boundary exists.

## Review checklist

- What concrete change or coupling requires this principle?
- Is the proposed boundary owned by the consumer or policy that needs it?
- Can a direct function, struct, map, or standard-library type solve it?
- Does the abstraction have more than one real reason to exist?
- Do tests verify behavior through the same contract production code uses?
