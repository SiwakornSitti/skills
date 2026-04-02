# Inter-Module Communication

This document defines how different features (modules) within the `/internal` directory should interact and share data.

## Contents
- [1. Principles](#1-principles)
- [2. Communication Strategies](#2-communication-strategies)
- [3. Example: Account needing Customer Name](#3-example-account-needing-customer-name)
- [4. Handling Bi-Directional Dependencies (Circular Imports)](#4-handling-bi-directional-dependencies-circular-imports)

## 1. Principles

- **Avoid Circular Dependencies:** Features **must not** import each other in a way that creates a circular dependency.
- **Loose Coupling:** Modules should be as independent as possible. Communication should happen through well-defined interfaces.
- **Source of Truth:** Each piece of data (e.g., customer details) has a primary owner (the `customer` module). Other modules (e.g., `account`) should treat this owner as the source of truth.

## 2. Communication Strategies

### A. Service-to-Service Calls (via Interfaces)

When one module needs data or needs to trigger an action in another module, it should do so through an interface.

- Define a "Service Interface" in the consumer's package or a shared location. This follows the Dependency Inversion Principle.
- *Example:* The `account` service defines a `CustomerProvider` interface. The `customer` service then implements this interface and is injected at startup.

### B. Shared Models

Shared domain objects or common data types that are needed by multiple features should be placed in a separate, common package inside `/internal` (e.g., `/internal/shared/models`).

- This prevents one feature from having to import another just for a struct definition, reducing the risk of circular dependencies.

### C. Data Enrichment (Aggregation via Orchestrator)

If an endpoint needs to return data from multiple modules (e.g., showing an account with its customer name):

1. **At the Handler Layer (Orchestrator):** The handler acts as an orchestrator, calling multiple independent services and aggregating the results into a single response model. This ensures services remain unaware of each other.
2. **Denormalization:** For high-performance read scenarios, consider storing a copy of the essential fields (like `customer_name`) in the `account` record. These copies must be updated when the source of truth changes (e.g., via domain events).

### D. Domain Events (Async Communication)

For side effects across modules (e.g., "when an account is created, notify the customer module to update its statistics"), use an internal event dispatcher or a message bus.

- This allows the `account` module to remain unaware of the `customer` module's implementation.

## 3. Example: Account needing Customer Name

- **Wrong:** `account/repository` joins with the `customer` table directly (breaks module isolation).
- **Correct:** The `account/service` receives a `CustomerProvider` interface. It calls `provider.GetCustomerName(customerID)` to enrich the account data before returning it to the handler.

### Go Example Implementation

```go
// internal/account/service/service.go
package service

import "context"

// CustomerProvider is an interface that the account service needs.
// This prevents account from depending directly on the customer package.
type CustomerProvider interface {
 GetCustomerName(ctx context.Context, id string) (string, error)
}

type AccountService struct {
 customerProvider CustomerProvider
 repo             Repository
}

func New(cp CustomerProvider, r Repository) *AccountService {
 return &AccountService{
  customerProvider: cp,
  repo:             r,
 }
}

func (s *AccountService) GetAccountDetails(ctx context.Context, accountID string) (*AccountDetails, error) {
 acc, err := s.repo.FindByID(ctx, accountID)
 if err != nil {
  return nil, err
 }

 // Call the external module via the interface
 name, err := s.customerProvider.GetCustomerName(ctx, acc.CustomerID)
 if err != nil {
  return nil, err
 }

 return &AccountDetails{
  ID:           acc.ID,
  CustomerName: name,
  Balance:      acc.Balance,
 }, nil
}
```

```go
// internal/customer/service/service.go
package service

import "context"

type CustomerService struct {
 repo Repository
}

// GetCustomerName implements the interface needed by the account service.
func (s *CustomerService) GetCustomerName(ctx context.Context, id string) (string, error) {
 customer, err := s.repo.FindByID(ctx, id)
 if err != nil {
  return "", err
 }
 return customer.Name, nil
}
```

```go
// cmd/app/main.go
package main

import (
 accService "myproject/internal/account/service"
 custService "myproject/internal/customer/service"
)

func main() {
 // Initialize services
 customerSvc := custService.New(...)
 
 // Inject the customer service into the account service.
 // Since CustomerService implements GetCustomerName, it satisfies the CustomerProvider interface.
 accountSvc := accService.New(customerSvc, ...)
}
```

## 4. Handling Bi-Directional Dependencies (Circular Imports)

In Go, circular imports are forbidden. If `moduleA` needs `moduleB` and `moduleB` needs `moduleA`, use one of these strategies:

### A. Shared Interface Package

Move the interface definitions to a separate "shared" or "contract" package within `/internal` (e.g., `/internal/shared/contracts`).

- Both `moduleA` and `moduleB` import the shared package.
- This breaks the direct cycle because neither module imports the other's implementation.

#### Example: Bi-Directional Communication via Shared Contracts

```go
// internal/shared/contracts/contracts.go
package contracts

import "context"

type AccountService interface {
 GetBalance(ctx context.Context, id string) (int, error)
}

type CustomerService interface {
 GetCustomerName(ctx context.Context, id string) (string, error)
}
```

```go
// internal/account/service/service.go
package service

import (
 "context"
 "myproject/internal/shared/contracts" // Import shared interfaces
)

type AccountService struct {
 customerSvc contracts.CustomerService // Use shared interface
}

func (s *AccountService) GetBalance(ctx context.Context, id string) (int, error) {
 // ... implementation ...
 return 100, nil
}

func (s *AccountService) Process(ctx context.Context, custID string) {
 // Can call customer service safely
 name, _ := s.customerSvc.GetCustomerName(ctx, custID)
}
```

```go
// internal/customer/service/service.go
package service

import (
 "context"
 "myproject/internal/shared/contracts" // Import shared interfaces
)

type CustomerService struct {
 accountSvc contracts.AccountService // Use shared interface
}

func (s *CustomerService) GetCustomerName(ctx context.Context, id string) (string, error) {
 // ... implementation ...
 return "John Doe", nil
}

func (s *CustomerService) Notify(ctx context.Context, accID string) {
 // Can call account service safely without circular import
 balance, _ := s.accountSvc.GetBalance(ctx, accID)
}
```

### B. Orchestrator Pattern

Move the logic that requires both modules to a higher-level service or the `handler` layer.

- The `handler` (e.g., `/internal/featureA/handler/handler.go`) calls `serviceA` and then `serviceB` to complete the cross-module operation.
- Neither service needs to know about the other.

#### Example: Orchestration in Handler

```go
// internal/order/handler/handler.go
package handler

import (
 "net/http"
 "myproject/internal/order/service"
 inventorySvc "myproject/internal/inventory/service"
)

type OrderHandler struct {
 orderSvc     *service.OrderService
 inventorySvc *inventorySvc.InventoryService
}

func (h *OrderHandler) CreateOrder(w http.ResponseWriter, r *http.Request) {
 ctx := r.Context()
 
 // 1. Call Inventory Module to reserve stock
 err := h.inventorySvc.ReserveStock(ctx, "item-123", 1)
 if err != nil {
  http.Error(w, "Out of stock", http.StatusConflict)
  return
 }

 // 2. Call Order Module to create the order
 err = h.orderSvc.PlaceOrder(ctx, "item-123", "user-456")
 if err != nil {
  // Rollback logic might be needed here
  http.Error(w, "Failed to place order", http.StatusInternalServerError)
  return
 }

 w.WriteHeader(http.StatusCreated)
}
```

### C. Domain Events (Asynchronous)

Instead of `moduleA` calling `moduleB` directly, have `moduleA` emit an event (e.g., `AccountCreated`). `moduleB` then listens for this event and reacts accordingly.

- This is the most decoupled approach and is ideal for side effects.

### D. Re-evaluate Boundaries

If two modules constantly need each other's internals, they might actually be a single feature. Consider merging them into one package.
