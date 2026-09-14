# Slices and maps

- Treat a slice as a view over an array; `append` can reuse its backing array and alias another slice.
- Clone slices or maps before returning mutable internal state or accepting ownership that must remain private.
- Name collections by their element meaning and document whether a function borrows, copies, or takes ownership.
- Preserve nil-versus-empty behavior when it is part of the API or serialization contract.
- Protect map access with the owning concurrency design; this skill does not define synchronization.

```go
snapshot := slices.Clone(values)
```
