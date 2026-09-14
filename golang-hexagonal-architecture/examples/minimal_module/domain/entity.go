package domain

import (
	"errors"
	"time"
)

var (
	ErrInsufficientBalance = errors.New("insufficient balance")
	ErrInvalidAmount       = errors.New("amount must be greater than zero")
	ErrWalletNotFound      = errors.New("wallet not found")
)

// Wallet is the aggregate root owning balance invariants.
type Wallet struct {
	ID        string
	OwnerID   string
	Balance   int64 // Stored in minor currency units (e.g. cents)
	UpdatedAt time.Time
}

// Deposit credits amount to wallet balance.
func (w *Wallet) Deposit(amount int64) error {
	if amount <= 0 {
		return ErrInvalidAmount
	}
	w.Balance += amount
	w.UpdatedAt = time.Now().UTC()
	return nil
}

// Withdraw enforces the non-negative balance invariant.
func (w *Wallet) Withdraw(amount int64) error {
	if amount <= 0 {
		return ErrInvalidAmount
	}
	if w.Balance < amount {
		return ErrInsufficientBalance
	}
	w.Balance -= amount
	w.UpdatedAt = time.Now().UTC()
	return nil
}
