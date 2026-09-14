# Trust boundaries

- Authenticate and authorize at trust boundaries. A syntactically valid ID or
  user-controlled header is not proof of permission.
- Use typed inputs, bounded sizes, and explicit validation for external data.
- Return `401` for missing or invalid authentication and `403` for an
  authenticated caller without permission when the API contract distinguishes
  them.
- Keep transport-specific identity and authorization integration with the
  owning API boundary; this skill defines the secure checks.
