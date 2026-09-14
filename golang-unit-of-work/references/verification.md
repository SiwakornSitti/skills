# Verification

Add focused service or adapter unit tests for:

- begin failure;
- repository failure followed by rollback;
- commit failure followed by rollback cleanup;
- successful commit with deferred rollback;
- panic cleanup when the operation owns the UoW.

Use fresh test doubles per subtest and assert the typed accessor used by the
service. Do not use sleeps to prove transaction ordering.

Add at least one real database integration test that writes through two
transaction-bound repositories, forces the second write to fail, and verifies
that neither write is visible. Also verify the success path commits both writes.

Run the smallest relevant checks first, then the repository's normal suite:

```bash
go test ./path/to/service/...
go test -race ./path/to/service/...
go test -tags=integration ./path/to/outbound/repository/...
go test ./...
```

The skill is complete when the port remains infrastructure-free, every local
write is transaction-bound, cleanup preserves the primary error, and both unit
and real-database atomicity checks pass.
