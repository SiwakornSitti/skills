# API Specification (Swagger/OpenAPI)

All RESTful APIs **must** have a clear and up-to-date specification using the OpenAPI (Swagger) standard.

## 1. Requirements

- **Documentation First:** API specifications should ideally be designed before or during implementation.
- **Auto-Generation:** Use tools (like `swaggo/swag` for Go) to generate the OpenAPI 3.0 specification from code comments.
- **Completeness:** Every endpoint must document:
  - HTTP Method and Path.
  - Summary and Description.
  - Request Parameters (Query parameters for pagination/filtering, Path parameters, Body).
  - Required Headers (e.g., `Idempotency-Key` for `POST` requests).
  - Response Status Codes and Models (for both success and error cases).
- **Naming Conventions:** Ensure that model names and field names in the Swagger UI match the JSON response format strictly (`camelCase`, as defined in the RESTful API guidelines).

## 2. Generation & Validation

- **Pre-Commit Hook:** Developers **must** use a pre-commit hook (e.g., using [pre-commit](https://pre-commit.com/)) to automatically run the `swag init` command before every commit. This ensures that the generated `swagger.json` or `swagger.yaml` is never out of sync with the codebase annotations.
- **Local Development:** The Swagger UI should be accessible via a specific route (e.g., `/swagger/index.html`) when the application is running in a development environment.
- **CI/CD Integration:** The generated Swagger files must be validated as part of the CI pipeline. The pipeline should fail if the checked-in swagger files do not match the output of a fresh `swag init` run, indicating a bypassed pre-commit hook.

## 3. Example Comments for `swaggo/swag`

```go
// @Summary Create a new user
// @Description Create a user with the provided details
// @Tags users
// @Accept json
// @Produce json
// @Param Idempotency-Key header string true "Idempotency key to prevent duplicate creation"
// @Param user body CreateUserRequest true "User data"
// @Success 201 {object} UserResponse
// @Failure 400 {object} ErrorResponse
// @Failure 409 {object} ErrorResponse "Conflict: User already exists"
// @Router /users [post]
func (h *UserHandler) CreateUser(w http.ResponseWriter, r *http.Request) {
    // ...
}
```
