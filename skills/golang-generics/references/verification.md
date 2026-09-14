# Verification

- Test generic algorithms with at least two concrete types. Use benchmarks
  before making performance claims.

```go
func TestLast(t *testing.T) {
	if got, ok := Last([]string{"a", "b"}); !ok || got != "b" {
		t.Fatalf("Last(strings) = %q, %v", got, ok)
	}
	if got, ok := Last([]int{1, 2}); !ok || got != 2 {
		t.Fatalf("Last(ints) = %d, %v", got, ok)
	}
}
```

Run `go test ./...` after changing a generic API.
