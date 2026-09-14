package domain

import (
	"context"
)

// WalletRepository is the outbound port required by the domain.
// Adapters in outbound/ must satisfy this interface.
type WalletRepository interface {
	FindByID(ctx context.Context, id string) (*Wallet, error)
	Save(ctx context.Context, wallet *Wallet) error
}

// WalletService is the inbound port exposed by the core service.
// Transport adapters in inbound/ invoke this interface.
type WalletService interface {
	GetBalance(ctx context.Context, id string) (int64, error)
	Deposit(ctx context.Context, id string, amount int64) (*Wallet, error)
	Withdraw(ctx context.Context, id string, amount int64) (*Wallet, error)
}
