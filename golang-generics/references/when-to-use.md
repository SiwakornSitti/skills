# When to use generics

Use type parameters for a small, type-safe shared algorithm or when the type
relationship is part of the API. Start with a concrete implementation and
introduce generics when reuse across types is real; two call sites are useful
evidence, not a rule.

Do not start by designing constraints. Write the algorithm first, then
generalize only the operations that are genuinely shared.

```go
func Last[T any](values []T) (T, bool) {
	if len(values) == 0 {
		var zero T
		return zero, false
	}
	return values[len(values)-1], true
}
```

This is worth generalizing only when the same algorithm is needed for other
element types. Do not claim lower allocations or faster execution without a
benchmark.
