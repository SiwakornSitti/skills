# Wrapping and matching

Preserve the error chain until an inbound boundary translates it.

- Wrap operational failures with one useful operation label and `%w`.
- Use `errors.Is` for sentinel errors and `errors.AsType[T]` for typed errors
  on Go 1.27+.
- Do not replace `%w` with `%v`; that breaks unwrapping.
- Preserve `context.Canceled` and `context.DeadlineExceeded` so callers can
  still detect cancellation and timeout; wrapping with `%w` is allowed.
- Lower layers return errors without logging them. Follow
  `golang-apperror-logging` for the log-once rule.

```go
account, err := repo.FindByID(ctx, id)
if err != nil {
	if errors.Is(err, domain.ErrNotFound) {
		return nil, domain.ErrNotFound
	}
	return nil, fmt.Errorf("find account by id: %w", err)
}
```
