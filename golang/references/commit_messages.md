# Commit Messages (Conventional Commits)

This project strictly adheres to the [Conventional Commits](https://www.conventionalcommits.org/) specification for version control history. This enables readable history, automated changelog generation, and semantic versioning.

## 1. Commit Structure

Every commit message **must** follow this format:

```text
<type>[optional scope]: <description>

[optional body]

[optional footer(s)]
```

## 2. Allowed Types

Use the appropriate type to communicate the intent of your change:

- **`feat:`** A new feature (e.g., `feat(auth): add google oauth login`).
- **`fix:`** A bug fix (e.g., `fix(db): handle concurrent map write panic`).
- **`docs:`** Documentation changes only (e.g., `docs: update API swagger spec`).
- **`style:`** Changes that do not affect the meaning of the code, like white-space or formatting (e.g., `style: run gofmt on all handlers`).
- **`refactor:`** A code change that neither fixes a bug nor adds a feature (e.g., `refactor(core): simplify tax calculation logic`).
- **`perf:`** A code change that improves performance (e.g., `perf(query): replace N+1 query with inner join`).
- **`test:`** Adding missing tests or correcting existing tests (e.g., `test(service): add unit tests for account creation`).
- **`build:`** Changes that affect the build system or external dependencies (e.g., `build: bump golang version to 1.26`).
- **`ci:`** Changes to CI configuration files and scripts (e.g., `ci: add testcontainers to gitlab pipeline`).
- **`chore:`** Other changes that don't modify `src` or `test` files (e.g., `chore: update .gitignore to ignore idea files`).
- **`revert:`** Reverts a previous commit (e.g., `revert: "feat: add broken payment gateway"`).

## 3. Best Practices

- **Scope:** Optionally include a scope in parentheses after the type to indicate the area of the codebase (e.g., `feat(account): add user login`).
- **Description:** The description must be written in the imperative, present tense (e.g., `add user login` not `added user login` or `adds user login`). It should not end with a period.
- **Breaking Changes:** Any commit that introduces a breaking API change **must** append a `!` after the type/scope (e.g., `feat(auth)!: switch to PASETO tokens`). This correlates with a MAJOR release.
- **Body & Footer:** Use the optional body to explain *why* the change was made. Use the footer to reference Issue/Jira tracker IDs (e.g., `Fixes #123`, `Refs PROJ-456`).

## 4. Enforcement (commitlint)

To ensure consistency, this project uses `commitlint` (or a similar tool like `go-gitlint`) to validate commit messages.

- **Git Hooks:** A `commit-msg` husky/git hook is configured to validate your commit message locally before the commit is created.
- **CI Pipeline:** The CI/CD pipeline will also verify all commits in a merge request. Commits failing the format check will cause the build to fail.

## 5. Examples

- `feat(inventory): add stock deduction endpoint`
- `fix(db): correct N+1 query issue in get order list`
- `refactor(auth): move jwt logic to shared platform package`
- `build: update golang version to 1.26`
- `feat(payment)!: remove legacy v1 stripe integration`
