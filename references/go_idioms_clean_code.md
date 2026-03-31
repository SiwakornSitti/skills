# Go Idioms and Clean Code

This document outlines the coding standards and idiomatic patterns for Go development in this project.

## 1. General Principles

- **Explicit is better than implicit:** Avoid "magic" behavior or heavy reliance on reflection/global state.
- **Keep it simple:** Prefer simple, readable solutions over complex, "clever" ones.
- **YAGNI (You Aren't Gonna Need It):** Implement things only when you actually need them, not when you foresee that you might need them.
- **DRY (Don't Repeat Yourself):** Abstract out duplicated logic to keep the codebase maintainable and reduce the surface area for bugs.
- **Composition over inheritance:** Use embedding and interfaces rather than trying to mimic object-oriented inheritance.

## 2. Naming Conventions

- **Package Names:** Use short, lower-case, single-word names (e.g., `user`, `auth`). Avoid `snake_case` or `camelCase`.
  - If a single word is not possible, try to find a more descriptive single word or use a sub-package (e.g., `internal/auth/token`).
  - If words must be concatenated, do not use any separators (e.g., `urlparse`, `tabwriter`).
- **Variables/Functions:** Use `MixedCaps` (CamelCase).
- **Booleans:** Boolean variables and functions returning booleans should start with words like `is`, `has`, `can`, or `should` (e.g., `isActive`, `hasPermission()`).
- **Receiver Names:** Use short, one or two-letter abbreviations (e.g., `u *User`, `s *Service`). Avoid `self` or `this`.
- **No "Get" Prefix:** For getter methods, avoid the "Get" prefix (e.g., use `u.Name()` instead of `u.GetName()`).

## 3. Error Handling

- **Errors are values:** Treat errors as first-class citizens. Always check for them.
- **Handle or return:** Every error should either be handled (logged/recovered) or returned to the caller. Do not do both.
- **Wrap errors:** Use `fmt.Errorf("...: %w", err)` to provide context as errors bubble up.

## 4. Interfaces

- **Keep them small:** Prefer small, focused interfaces (e.g., `io.Reader`). One or two methods is often enough.
- **Define where used:** Interfaces should generally be defined in the package that *consumes* them, not the package that *implements* them.

## 5. Concurrency

- **Share by communicating:** "Do not communicate by sharing memory; instead, share memory by communicating." Use channels for coordination where appropriate.
- **Goroutine Leaks:** Always ensure goroutines have a way to exit cleanly (e.g., using `context.Context`).

## 6. Tools, Formatting, and Linting

- **`gofmt`:** All code **must** be formatted with `gofmt` or `goimports`.
- **`golangci-lint`:** To enforce clean code and maintain high code quality, running `golangci-lint` is mandatory.
  - **Pre-commit / CI:** Linting must pass locally before committing and is enforced in the CI/CD pipeline.
  - **Configuration:** Maintain a strict `.golangci.yml` at the project root to enable rules for complexity, dead code, error checking, and styling.
