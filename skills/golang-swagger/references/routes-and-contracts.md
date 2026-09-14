# Routes and HTTP Contracts

## Route parity

Each module registers endpoints through
`RegisterRoutes(router *mux.Router)` using direct
`router.HandleFunc(path, handler).Methods(http.MethodX)` calls. Copy the exact
path and method into `@Router`; the registered route is authoritative.

```go
// getByID godoc
// @Summary Get account by ID
// @Tags accounts
// @Produce json
// @Param id path string true "Account ID"
// @Success 200 {object} accountResponse
// @Failure 404 {object} httpserver.ErrorResponse
// @Failure 500 {object} httpserver.ErrorResponse
// @Router /accounts/{id} [get]
func (h *Handler) getByID(w http.ResponseWriter, r *http.Request) {}

router.HandleFunc("/accounts/{id}", h.getByID).Methods(http.MethodGet)
```

Check every registered endpoint has one matching annotation. Treat path
variables, HTTP verbs, and route prefixes as contract data, not prose.

## Parameters and content types

Document every runtime input source:

- `path` parameters for `mux.Vars(r)` values;
- `query` parameters for pagination and filters;
- `header` parameters for required headers such as `X-User-ID`;
- `body` parameters for JSON decoded and validated request DTOs.

```go
// @Param userID path string true "User ID"
// @Param X-User-ID header string true "User ID"
// @Param limit query int false "Max results (default 20, max 100)"
// @Param offset query int false "Offset for pagination"
```

Use `@Accept json` only for endpoints that decode JSON bodies. Use
`@Produce json` when the endpoint writes JSON. A `204 No Content` endpoint has no JSON
response body.

## Responses

The standard paginated response is an object containing `items`, `limit`,
`offset`, and `total`, created by `httpserver.NewPage`:

```go
// @Success 200 {object} accountPageResponse
```

The standard error envelope contains both stable fields:

```go
type ErrorResponse struct {
	Code  string `json:"code"`
	Error string `json:"error"`
}
```

Use `{object} httpserver.ErrorResponse` for each reachable failure status.
Derive failures from the handler's `WriteError` branches, including `500` when
the handler can emit it. Keep error codes stable even when human messages
change.

For no-content operations, document the status without an invented response
model:

```go
// @Success 204 "No Content"
```
