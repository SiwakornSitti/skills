# Nil and interfaces

- Check pointers before dereferencing and return an untyped `nil` instead of a typed nil pointer inside an interface.
- Initialize maps before writes; nil maps can be read and ranged but writes panic.
- Initialize channels before use; nil channels block forever on send and receive.
- Use comma-ok assertions for expected type variation; reserve direct assertions for invariants enforced at the boundary.
- Keep concurrent map access and synchronization rules in [golang-concurrency](../../golang-concurrency/SKILL.md).

```go
value, ok := input.(Expected)
if !ok {
	return ErrInvalidInput
}
```
