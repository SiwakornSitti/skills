package minimalmodule

import (
	"github.com/example/go-hexagonal/.agents/skills/golang-hexagonal-architecture/examples/minimal_module/domain"
	inboundhttp "github.com/example/go-hexagonal/.agents/skills/golang-hexagonal-architecture/examples/minimal_module/inbound/http"
	"github.com/example/go-hexagonal/.agents/skills/golang-hexagonal-architecture/examples/minimal_module/outbound/repository/db"
	"github.com/example/go-hexagonal/.agents/skills/golang-hexagonal-architecture/examples/minimal_module/service"
	"github.com/gorilla/mux"
)

// Module encapsulates the minimal wallet bounded context.
type Module struct {
	Service domain.WalletService
	Handler *inboundhttp.Handler
}

// New is the composition root assembling concrete adapters and core services.
func New() *Module {
	// 1. Construct outbound persistence adapter
	repo := db.New()

	// 2. Construct domain service injecting outbound port
	svc := service.New(repo)

	// 3. Construct inbound HTTP transport adapter injecting domain service
	handler := inboundhttp.New(svc)

	return &Module{
		Service: svc,
		Handler: handler,
	}
}

// RegisterRoutes wires the module's HTTP endpoints.
func (m *Module) RegisterRoutes(r *mux.Router) {
	m.Handler.RegisterRoutes(r)
}
