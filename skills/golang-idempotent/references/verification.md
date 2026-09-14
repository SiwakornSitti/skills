# Verification

- Test duplicate requests and confirm the side effect runs once and the stored
  response is replayed.
- Test concurrent requests with the same key and verify only one request owns
  the claim.
- Test mismatched payloads, retry after transient failure, expired keys,
  existing in-progress claims, store errors, and replayed headers.
- Test the same business write and idempotency record through the real Unit of
  Work or storage integration when atomicity cannot be proven with a fake.
