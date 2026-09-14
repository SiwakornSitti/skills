---
name: twelve-factor
description: Apply Twelve-Factor App practices to service design and deployment, especially configuration, process lifecycle, dependencies, logs, and runtime boundaries.
license: MIT
metadata:
  tags: [twelve-factor, cloud-native, operations]
---

# Twelve-Factor applications

Keep services portable, observable, and independently deployable. Read the
reference for the factor affected by the change:

- [codebase.md](references/codebase.md) — tracked source and repeatable builds.
- [dependencies.md](references/dependencies.md) — explicit dependencies and reproducibility.
- [config.md](references/config.md) — runtime configuration, secrets, and startup validation.
- [backing-services.md](references/backing-services.md) — replaceable runtime resources.
- [build-release-run.md](references/build-release-run.md) — immutable release phases.
- [processes.md](references/processes.md) — stateless process design.
- [port-binding.md](references/port-binding.md) — configured self-contained network services.
- [concurrency.md](references/concurrency.md) — process and worker scaling.
- [disposability.md](references/disposability.md) — startup, shutdown, bounded work, and restarts.
- [dev-prod-parity.md](references/dev-prod-parity.md) — matching development and production workflows.
- [logs.md](references/logs.md) — event streams and collection boundaries.
- [admin-processes.md](references/admin-processes.md) — explicit repeatable administrative commands.

Completion check: read the reference matching the change, apply its
implementation requirements, and verify the affected service or deployment.

Apply these practices when they solve a deployment or operations problem; do
not add infrastructure abstractions without a concrete need.

## Related skills

- [software-principles](../software-principles/SKILL.md)
