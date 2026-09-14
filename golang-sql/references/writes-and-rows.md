# Writes and row outcomes

- Check affected-row counts when a successful write must affect an existing
  row.
- Distinguish a successful zero-row update or delete from a write that changed
  the intended resource; map the result at the repository boundary.
- Keep write statements parameterized and return domain-relevant outcomes
  rather than driver-specific details.
