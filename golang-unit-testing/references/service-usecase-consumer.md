# Domain, service, use-case, and consumer tests

## Domain tests

Pure domain logic should be the cheapest and most direct unit to test:

```go
func TestDebit(t *testing.T) {
	tests := []struct {
		name    string
		balance int64
		amount  int64
		want    int64
		wantErr error
	}{
		{name: "debits balance", balance: 100, amount: 40, want: 60},
		{name: "rejects insufficient funds", balance: 20, amount: 40, wantErr: ErrInsufficientFunds},
	}

	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			got, err := Debit(Account{Balance: tt.balance}, tt.amount)
			if !errors.Is(err, tt.wantErr) {
				t.Fatalf("err = %v, want %v", err, tt.wantErr)
			}
			if got.Balance != tt.want {
				t.Fatalf("balance = %d, want %d", got.Balance, tt.want)
			}
		})
	}
}
```

Include boundary values, invalid input, domain sentinels, and unchanged state
when the operation fails. Use `errors.Is` for wrapped sentinel errors and
`errors.As` for typed errors; compare exact text only when it is an external
contract.

## Service and use-case tests

Set up only the ports needed for the scenario. Verify the result and important
side effects, not every private statement.

For a transactional service, cover at least:

- Successful work commits once.
- Domain validation failure rolls back and performs no write.
- Repository failure rolls back and preserves the operational error contract.
- Commit failure is returned and does not report success.
- No message publication or external side effect occurs after rollback.

Use context-aware expectations. Match exact IDs and domain values when they are
part of the contract; use broad matchers only for derived timestamps or other
values whose exact value is not under test.

## Consumer handler tests

Pass JSON bytes directly to consumer handlers. Do not start a broker for a unit
test.

- Valid payload delegates the expected command to the service.
- Malformed JSON returns a decode error without calling the service.
- Service and domain errors preserve their classification.
- Repeated delivery is safe when the consumer contract requires idempotency.
- Context cancellation stops work and is not converted into false success.

Durable acknowledgement, retry, dead-letter, offset, and broker redelivery
behavior belongs in integration or consumer-system tests.
