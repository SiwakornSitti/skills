# In-process errors

## Eliminate error handling by eliminating errors

Prevent avoidable failures at the boundary: validate untrusted input, enforce
domain invariants before side effects, and let the database enforce durable
constraints. This reduces error paths; it never means ignoring, swallowing, or
replacing an error that can still occur.

Handle every returned error at the current boundary. Classify it with
`errors.Is` or `errors.As`, wrap it with `%w` while returning it, or translate
it into the boundary's domain/transport error. Do not discard it with `_`,
return success after an error, or turn it into text that breaks unwrapping.

## Outbound Adapter (`outbound/repository/repository.go`)

```go
func (r *repository) FindByID(ctx context.Context, id string) (*domain.Account, error) {
    var a domain.Account
    err := r.db.QueryRow(ctx, query, id).Scan(&a.ID, &a.Balance)
    if errors.Is(err, pgx.ErrNoRows) {
        return nil, domain.ErrNotFound // Map to domain error; DO NOT log
    }
    if err != nil {
        return nil, fmt.Errorf("query account %s: %w", id, err) // Wrap; DO NOT log
    }
    return &a, nil
}
```

## Domain Service (`service/service.go`)

```go
func (s *service) GetByID(ctx context.Context, id string) (*domain.Account, error) {
    account, err := s.repo.FindByID(ctx, id)
    if err != nil {
        return nil, fmt.Errorf("get account by id: %w", err) // Wrap; DO NOT log
    }
    return account, nil
}
```

## Inbound Handler Boundary (`inbound/http/handler.go`)

```go
func (h *Handler) GetAccount(w http.ResponseWriter, r *http.Request) {
    id := mux.Vars(r)["id"]
    account, err := h.svc.GetByID(r.Context(), id)
    if err != nil {
        if errors.Is(err, domain.ErrNotFound) {
            // WriteError logs internally via logger.FromContext(r.Context())
            httpserver.WriteError(w, r, http.StatusNotFound, "ACCOUNT_NOT_FOUND", "account not found", err)
            return
        }
        httpserver.WriteError(w, r, http.StatusInternalServerError, "INTERNAL_ERROR", "", err)
        return
    }
    httpserver.WriteJSON(w, http.StatusOK, account)
}
```
