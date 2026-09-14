# Boundaries

- Keep domain entities, use cases, repositories, and transport DTOs concrete.
  A generic `Repository[T]` hides domain behavior rather than sharing an
  algorithm.
- Prefer typed values to `any`; use `any` only at a real dynamic boundary,
  such as decoded JSON.
- Design generic types for useful zero values when practical. Avoid hidden
  initialization when the algorithm does not require state.
- Use ordinary interfaces for behavior and ports. Do not replace a concrete
  domain contract with a generic interface without a demonstrated need.
