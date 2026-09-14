package db

import (
	"context"
	"sync"

	"github.com/example/go-hexagonal/.agents/skills/golang-hexagonal-architecture/examples/minimal_module/domain"
)

type inMemoryRepository struct {
	mu      sync.RWMutex
	wallets map[string]*domain.Wallet
}

// New creates an in-memory repository adapter satisfying domain.WalletRepository.
func New() domain.WalletRepository {
	return &inMemoryRepository{
		wallets: make(map[string]*domain.Wallet),
	}
}

func (r *inMemoryRepository) FindByID(ctx context.Context, id string) (*domain.Wallet, error) {
	r.mu.RLock()
	defer r.mu.RUnlock()

	w, exists := r.wallets[id]
	if !exists {
		return nil, domain.ErrWalletNotFound
	}
	// Return defensive copy
	copy := *w
	return &copy, nil
}

func (r *inMemoryRepository) Save(ctx context.Context, wallet *domain.Wallet) error {
	r.mu.Lock()
	defer r.mu.Unlock()

	copy := *wallet
	r.wallets[wallet.ID] = &copy
	return nil
}
