# Transactions and Unit of Work

- Use the context's existing Unit of Work for atomic multi-repository writes.
- A read-only query does not need a transaction.
- Keep the transaction boundary around the complete business operation. Do not
  hold a transaction across unrelated network calls or response writing.
- Commit only after all required writes succeed; roll back on failure or
  cancellation.
