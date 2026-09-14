# Standard library and algorithms

Prefer `slices`, `maps`, and `cmp` from the standard library before writing a
generic helper. A custom helper must provide a clear algorithmic benefit or a
stable reuse seam.

```go
if slices.Contains(statuses, domain.StatusActive) {
	// process active status
}
```

Keep generic helpers close to their callers until reuse is stable across
packages. Do not create a generic repository, service, or factory merely to
remove a few repeated lines.
