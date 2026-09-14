package service

import (
	"context"
	"fmt"

	"github.com/example/go-hexagonal/.agents/skills/golang-hexagonal-architecture/examples/minimal_module/domain"
)

type walletService struct {
	repo domain.WalletRepository
}

// New constructs the core domain service.
func New(repo domain.WalletRepository) domain.WalletService {
	return &walletService{repo: repo}
}

func (s *walletService) GetBalance(ctx context.Context, id string) (int64, error) {
	wallet, err := s.repo.FindByID(ctx, id)
	if err != nil {
		return 0, fmt.Errorf("finding wallet: %w", err)
	}
	return wallet.Balance, nil
}

func (s *walletService) Deposit(ctx context.Context, id string, amount int64) (*domain.Wallet, error) {
	wallet, err := s.repo.FindByID(ctx, id)
	if err != nil {
		return nil, fmt.Errorf("finding wallet: %w", err)
	}
	if err := wallet.Deposit(amount); err != nil {
		return nil, err
	}
	if err := s.repo.Save(ctx, wallet); err != nil {
		return nil, fmt.Errorf("saving wallet: %w", err)
	}
	return wallet, nil
}

func (s *walletService) Withdraw(ctx context.Context, id string, amount int64) (*domain.Wallet, error) {
	wallet, err := s.repo.FindByID(ctx, id)
	if err != nil {
		return nil, fmt.Errorf("finding wallet: %w", err)
	}
	if err := wallet.Withdraw(amount); err != nil {
		return nil, err
	}
	if err := s.repo.Save(ctx, wallet); err != nil {
		return nil, fmt.Errorf("saving wallet: %w", err)
	}
	return wallet, nil
}
