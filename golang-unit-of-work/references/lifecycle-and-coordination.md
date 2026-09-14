# Lifecycle and Coordination

## Service lifecycle

Begin with the operation context, immediately schedule rollback, perform every
local read and write through the UoW accessors, and commit exactly once after
all local work succeeds.

```go
func (s *service) Create(ctx context.Context, cmd domain.CreateCommand) (*domain.Account, error) {
	uow, err := s.uowFactory.Begin(ctx)
	if err != nil {
		return nil, fmt.Errorf("begin unit of work: %w", err)
	}
	defer func() {
		rollbackCtx := ctx
		if ctx.Err() != nil {
			var cancel context.CancelFunc
			rollbackCtx, cancel = context.WithTimeout(context.Background(), time.Second)
			defer cancel()
		}
		_ = uow.Rollback(rollbackCtx)
	}()

	accounts := uow.Accounts()
	a, err := accounts.FindByUserID(ctx, cmd.UserID)
	if err != nil && !errors.Is(err, domain.ErrNotFound) {
		return nil, fmt.Errorf("check existing account: %w", err)
	}
	if err == nil {
		return nil, domain.ErrAlreadyExists
	}

	a = &domain.Account{
		ID:        uuid.New().String(),
		UserID:    cmd.UserID,
		Currency:  cmd.Currency,
		Status:    domain.StatusActive,
		CreatedAt: time.Now().UTC(),
	}
	if err := accounts.Save(ctx, a); err != nil {
		return nil, fmt.Errorf("save account: %w", err)
	}
	if err := uow.Commit(ctx); err != nil {
		return nil, fmt.Errorf("commit: %w", err)
	}
	return a, nil
}
```

The example uses `context.Background()` only as bounded cleanup fallback after
the operation context is already cancelled. Pass the operation context to
`Begin`, repository calls, and `Commit` while it remains valid.

Rollback is a safety net for early returns and panics. Do not let deferred
rollback obscure the primary error. Do not call `Commit` twice, and do not begin
transactions in HTTP handlers.

## Local outbox writes

When local data and an event record must agree, write both through the same UoW:

```go
users := uow.Users()
if err := users.Save(ctx, user); err != nil {
	return err
}
if err := uow.Outbox().Save(ctx, entry); err != nil {
	return fmt.Errorf("save outbox entry: %w", err)
}
if err := uow.Commit(ctx); err != nil {
	return fmt.Errorf("commit: %w", err)
}
```

This guarantees local database atomicity, not delivery. Keep relay polling,
retry, backoff, failure state, and consumer behavior in
`golang-transactional-outbox` or the relevant consumer skill.

Remote calls and message publication happen after the local transaction, or
are triggered by the outbox relay. Never hold a local transaction open while
waiting on another bounded context.

## Cache and retries

Cache invalidation is outside the UoW. Invalidate or refresh after a successful
commit, or publish an event for a cache-owning consumer. Never claim atomicity
between the database and a cache.

The UoW does not retry transactions generically. If serialization or deadlock
errors require retry, classify the database error and retry the complete
idempotent operation at an explicit application boundary.
