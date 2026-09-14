# Annotations and Models

## Inspect first

Before adding or changing an annotation, read the handler function, its
`RegisterRoutes` entry, request and response DTOs, and the relevant helpers in
`pkg/httpserver`. The handler behavior and JSON tags define the contract.

Comments belong directly above the actual documented function. This repository
uses unexported endpoint methods such as `list` and `create`; do not rename them
or require exported handlers for Swagger documentation.

Use the repository's annotation shape:

```go
// create godoc
// @Summary Create a new account
// @Description Create a new account for a user with specified currency
// @Tags accounts
// @Accept json
// @Produce json
// @Param request body createRequest true "Account creation request"
// @Success 201 {object} accountResponse
// @Failure 400 {object} httpserver.ErrorResponse
// @Failure 409 {object} httpserver.ErrorResponse
// @Failure 422 {object} httpserver.ErrorResponse
// @Router /accounts [post]
func (h *Handler) create(w http.ResponseWriter, r *http.Request) {}
```

Include `@Summary`, `@Tags`, request `@Param` entries, success response,
reachable failure responses, and `@Router`. Add `@Description`, `@Accept json`,
and `@Produce json` when they describe the real endpoint.

## DTOs

Document the request and response DTO returned on the wire. Preserve the
repository's unexported DTO convention when Swaggo resolves the type; do not
replace DTOs with domain entities merely to make a schema convenient.

Use JSON tags as the field names and account for `omitempty`, formatted times,
nullable pointers, and nested summaries. A response model must describe what
`WriteJSON` actually receives.

For collection endpoints, use a concrete named page response when the generator
cannot render a precise generic model. The model must expose the actual wrapper
fields rather than declaring the response as a raw array.

```go
type accountPageResponse struct {
	Items  []accountResponse `json:"items"`
	Limit  int               `json:"limit"`
	Offset int               `json:"offset"`
	Total  int               `json:"total"`
}

// @Success 200 {object} accountPageResponse
```

Keep schema changes and annotation changes together, then regenerate the
artifacts. Do not invent fields, examples, or security requirements that the
handler does not implement.
