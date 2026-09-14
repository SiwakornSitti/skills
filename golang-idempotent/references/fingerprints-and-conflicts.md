# Fingerprints and conflicts

- Bind each key to a canonical request fingerprint in addition to the caller,
  operation, and resource owner.
- Reuse with different input must return a conflict; never return the old result
  for a different request.
- Define canonicalization for fields whose equivalent representations should
  produce the same fingerprint. Preserve meaningful differences.
- Keep request payloads and fingerprints out of logs unless the metadata is
  explicitly safe and bounded.
