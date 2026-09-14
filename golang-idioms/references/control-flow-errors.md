# Control flow and errors

## Keep the Happy Path to the Left

Use guard clauses with early returns. Avoid deeply nested `if/else` blocks:

```go
func (s *service) Debit(ctx context.Context, cmd domain.DebitCommand) (*domain.Account, error) {
    a, err := s.repo.FindByID(ctx, cmd.AccountID)
    if err != nil {
        return nil, fmt.Errorf("find account: %w", err)
    }

    if a.Balance < cmd.Amount {
        return nil, domain.ErrInsufficientFunds
    }

    a.Balance -= cmd.Amount
    if err := s.repo.Update(ctx, a); err != nil {
        return nil, fmt.Errorf("update balance: %w", err)
    }

    return a, nil
}
```

## Wrap Errors with Context

- Wrap operational errors using `fmt.Errorf("action description: %w", err)`.
- Use `errors.Is(err, target)` for sentinel domain errors (e.g. `domain.ErrNotFound`).
- Use `errors.As(err, &target)` for structured error models (e.g. `*apperror.Error`).
