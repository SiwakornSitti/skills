---
name: software-principles
description: Applies DRY, SOLID, KISS, YAGNI, Law of Demeter, and Functional Core, Imperative Shell to software design, implementation, and code review without adding speculative abstractions.
license: MIT
metadata:
  tags: [software-design, dry, solid, kiss, yagni, law-of-demeter, functional-core, imperative-shell]
---

# Software principles

Read the matching reference before applying this skill:

- [overview.md](references/overview.md) — choose and combine principles, including conflict priority.
- [dry.md](references/dry.md) — remove duplicated knowledge safely.
- [solid.md](references/solid.md) — use cohesive responsibilities and real boundaries.
- [kiss.md](references/kiss.md) — prefer the simplest working design.
- [yagni.md](references/yagni.md) — defer speculative flexibility.
- [law-of-demeter.md](references/law-of-demeter.md) — keep collaborators close.
- [functional-core-imperative-shell.md](references/functional-core-imperative-shell.md) — isolate pure decisions from effects.

## Priority

Preserve correctness, security, data integrity, and the user's explicit contract before applying any principle. Then choose the smallest design that removes duplication, keeps responsibilities cohesive, and avoids speculative flexibility.

Completion check: read every reference matching the task, apply its implementation requirements, and leave one focused test or runnable check for every non-trivial change.
