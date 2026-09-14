# Atomic Local Write

When a local write emits an event, record the event inside the active Unit of
Work so business data and the outbox entry commit or roll back together:

```go
func (s *service) CreateAccount(ctx context.Context, cmd domain.CreateCommand) (*domain.Account, error) {
	uow, err := s.uowFactory.Begin(ctx)
	if err != nil {
		return nil, fmt.Errorf("begin transaction: %w", err)
	}
	defer uow.Rollback(ctx)

	account := domain.NewAccount(cmd.UserID, cmd.Currency)
	if err := uow.Accounts().Save(ctx, account); err != nil {
		return nil, fmt.Errorf("save account: %w", err)
	}

	payload, err := json.Marshal(AccountCreatedEvent{
		AccountID: account.ID,
		UserID:    account.UserID,
	})
	if err != nil {
		return nil, fmt.Errorf("marshal account event: %w", err)
	}

	event := &outbox.Entry{
		ID:        uuid.NewString(),
		EventType: "account.created",
		Payload:   payload,
		CreatedAt: time.Now().UTC(),
	}
	if err := uow.Outbox().Save(ctx, event); err != nil {
		return nil, fmt.Errorf("save outbox event: %w", err)
	}

	if err := uow.Commit(ctx); err != nil {
		return nil, fmt.Errorf("commit: %w", err)
	}
	return account, nil
}
```

Use the operation context for begin, repository calls, and commit. Schedule
rollback immediately after a successful begin; make deferred cleanup harmless
after commit and preserve the primary error.

The outbox entry records intent, not delivery. Do not publish directly to a
broker inside the handler or while holding the database transaction.
