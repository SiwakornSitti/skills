# Antigravity (AGY) Guide — Skills Repository

This repository provides **43 specialized skills** formatted according to the Antigravity Customization System specification.

## Skill Discovery

Antigravity automatically discovers skills in `.agents/skills/<skill-name>/SKILL.md`.

All skills in this repository are mounted under:
- `.agents/skills/` (workspace discovery)
- Native subdirectories: `./<skill-name>/`

## Best Practices

1. **Progressive Disclosure**:
   - Only activate the specific skill relevant to the active prompt.
   - Do not pull bulky reference manuals into context unless specifically needed.
2. **Hexagonal Architecture**:
   - Strictly isolate `domain/` packages from infrastructure dependencies (`pgx`, `database/sql`, `net/http`).
   - Wire adapters exclusively in module composition roots (`module.go` or `cmd/`).
3. **Automated Verification**:
   - When modifying architectural components, run the verification scripts under `.agents/skills/<skill-name>/scripts/` where available.
