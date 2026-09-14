---
name: conventional-commits
description: Write and validate Conventional Commit messages for repository changes. Use when creating, reviewing, or amending commit messages.
---

# Conventional Commits

Use this format:

```text
<type>[optional scope]: <description>
```

Use a concise, imperative, lowercase description. Choose the type that best
describes the staged change:

- `feat` — add user-visible or developer-visible capability
- `fix` — correct incorrect behavior
- `refactor` — change structure without changing behavior
- `perf` — improve performance
- `test` — add or change tests
- `docs` — change documentation
- `build` — change build or dependency configuration
- `ci` — change continuous integration or delivery
- `chore` — maintenance that does not fit another type
- `revert` — revert an earlier commit

Use a scope when it identifies the affected component, such as `user`,
`repository`, `migrations`, or `ci`:

```text
feat(user): add cached repository decorator
fix(repository): preserve not-found errors
ci: run integration tests in parallel
docs: update project structure
```

Mark incompatible changes with `!` after the type or scope and explain the
impact in the body or a `BREAKING CHANGE:` footer:

```text
feat(migrations)!: store identifiers as native uuid
```

Before committing, inspect the staged diff, keep one coherent purpose per
commit, and make the message describe the staged change. Run the repository's
focused checks and `git diff --cached --check` before creating the commit.
