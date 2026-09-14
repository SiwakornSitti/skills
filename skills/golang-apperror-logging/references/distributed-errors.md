# Distributed errors

When Service A calls Service B over HTTP/gRPC and Service B fails:

- Service B logs the error and returns a structured error with a machine-readable code.
- Service A must **not** re-log the error if Service B already logged it.

## The `apperror.Error` Abstraction

```go
package apperror

type Error struct {
    Code   string
    Logged bool // True if already logged by downstream service
}

func (e *Error) Error() string { return e.Code }

func New(code string) *Error       { return &Error{Code: code} }
func NewLogged(code string) *Error { return &Error{Code: code, Logged: true} }
```

## Downstream Service (Logs Once & Flags Error)

```go
func (s *downstreamService) Process(ctx context.Context) error {
    if err := s.repo.Save(ctx, item); err != nil {
        logger.FromContext(ctx).Error("failed to process item", slog.String("error", err.Error()))
        return apperror.NewLogged("ITEM_PROCESSING_FAILED")
    }
    return nil
}
```

## Upstream Service (Inspects Flag & Avoids Duplicate Logging)

```go
func (h *Handler) HandleRequest(w http.ResponseWriter, r *http.Request) {
    err := h.svc.CallDownstream(r.Context())
    if err != nil {
        var appErr *apperror.Error
        if errors.As(err, &appErr) && appErr.Logged {
            httpserver.WriteError(w, r, http.StatusBadGateway, appErr.Code, "", nil)
            return
        }

        httpserver.WriteError(w, r, http.StatusInternalServerError, "INTERNAL_ERROR", "", err)
        return
    }
}
```
