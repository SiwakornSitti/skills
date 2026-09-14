# HTTP handler tests

Use the repository's Gorilla Mux router and `httptest`; do not use a different
router in documentation examples or tests.

```go
func newRouter(t *testing.T, svc domain.Service) *mux.Router {
	t.Helper()
	h := handler.NewHandler(svc, validator.New())
	router := mux.NewRouter()
	h.RegisterRoutes(router)
	return router
}

func TestCreate(t *testing.T) {
	svc := mocks.NewMockService(t)
	svc.On("Create", mock.Anything, domain.CreateCommand{
		UserID: "user-1", Currency: "USD",
	}).Return(&domain.Account{ID: "acc-1", UserID: "user-1"}, nil)

	req := httptest.NewRequest(http.MethodPost, "/accounts",
		strings.NewReader(`{"user_id":"user-1","currency":"USD"}`))
	rec := httptest.NewRecorder()
	newRouter(t, svc).ServeHTTP(rec, req)

	if rec.Code != http.StatusCreated {
		t.Fatalf("status = %d, want %d", rec.Code, http.StatusCreated)
	}
	if got := rec.Header().Get("Content-Type"); !strings.HasPrefix(got, "application/json") {
		t.Fatalf("content type = %q, want application/json", got)
	}
}
```

For each handler contract, cover valid input, malformed JSON, validation
failure, route/path values, domain sentinel errors, and unexpected service
errors. Assert status, content type, and stable response fields. Do not assert
incidental whitespace, serialization order, or raw internal error text.

Decode response bodies into a small response struct when several fields matter;
use a substring check only for a single stable field. Verify that invalid input
does not call the service when that is part of the handler contract.
