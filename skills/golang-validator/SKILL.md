---
name: golang-validator
description: Use github.com/go-playground/validator/v10 for structural validation in Go.
license: MIT
compatibility: Requires Go 1.22+ and github.com/go-playground/validator/v10.
metadata:
  version: "1.0"
  tags: [go, validation, input, domain, api]
---

# Go validator/v10

This skill is limited to `github.com/go-playground/validator/v10`. Read the topic reference that matches the package change:

- [tags-and-structs.md](references/tags-and-structs.md) — built-in tags, nested values, and struct options.
- [custom-rules.md](references/custom-rules.md) — custom validators and registration.
- [errors-and-fields.md](references/errors-and-fields.md) — classify validation errors and map field names.
- [lifecycle-and-tests.md](references/lifecycle-and-tests.md) — configure, reuse, and test the validator.

Completion check: initialize one validator/v10 instance during application startup, inject and reuse it, preserve the service error contract, and run focused tests.

## Related skills

- [golang-rest-api-design](../golang-rest-api-design/SKILL.md)
- [golang-config-secrets](../golang-config-secrets/SKILL.md)
- [golang-error-handling](../golang-error-handling/SKILL.md)
- [golang-unit-testing](../golang-unit-testing/SKILL.md)
