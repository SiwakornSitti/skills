# Requests

- Decode JSON once with `httpserver.DecodeAndValidate`. Reject malformed JSON,
  invalid types, and invalid values at the trust boundary according to the
  shared decoder policy.
- Bound client-controlled request bodies before decoding.
- Keep transport DTOs separate from domain entities. DTOs own JSON names,
  validation tags, and transport compatibility; domain types own invariants.
- Use `camelCase` JSON names when that is the public contract. Normalize only
  values with an explicit contract, such as trimming a name or canonicalizing
  an email. Do not silently change identifiers or monetary values.
