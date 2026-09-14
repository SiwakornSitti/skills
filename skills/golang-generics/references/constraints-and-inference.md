# Constraints and inference

- Put type parameters on functions or types only when the type relationship is
  part of the API.
- Use the narrowest constraint that expresses the required operations. Use
  `comparable` only for equality or map keys.
- Use `~T` only when named types with underlying type `T` must be accepted.
- Prefer standard-library constraints such as `cmp.Ordered`; avoid adding an
  external constraints dependency for a small local requirement.
- Let callers use type inference where it is clear. Add explicit type
  arguments only when inference fails or readability improves.
- Go methods cannot declare new type parameters. Use a generic function, or
  parameterize the receiver type when the relationship belongs to that type.

```go
func Equal[T comparable](left, right T) bool {
	return left == right
}
```
