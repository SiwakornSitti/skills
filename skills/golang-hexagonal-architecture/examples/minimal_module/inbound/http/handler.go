package http

import (
	"encoding/json"
	"errors"
	"net/http"

	"github.com/example/go-hexagonal/.agents/skills/golang-hexagonal-architecture/examples/minimal_module/domain"
	"github.com/gorilla/mux"
)

type Handler struct {
	service domain.WalletService
}

// New constructs the HTTP transport adapter.
func New(service domain.WalletService) *Handler {
	return &Handler{service: service}
}

// RegisterRoutes attaches endpoints to the router.
func (h *Handler) RegisterRoutes(r *mux.Router) {
	r.HandleFunc("/wallets/{id}/balance", h.GetBalance).Methods(http.MethodGet)
}

func (h *Handler) GetBalance(w http.ResponseWriter, r *http.Request) {
	id := mux.Vars(r)["id"]
	balance, err := h.service.GetBalance(r.Context(), id)
	if err != nil {
		if errors.Is(err, domain.ErrWalletNotFound) {
			http.Error(w, "wallet not found", http.StatusNotFound)
			return
		}
		http.Error(w, "internal server error", http.StatusInternalServerError)
		return
	}

	w.Header().Set("Content-Type", "application/json")
	_ = json.NewEncoder(w).Encode(map[string]any{
		"wallet_id": id,
		"balance":   balance,
	})
}
