# Composition and orchestration

Model the BFF use case around the client outcome, then map that outcome to core-service calls. Keep orchestration in an application/use-case layer, not in HTTP handlers or low-level clients.

## Independent calls

Run independent reads concurrently only when the latency benefit is real and the fan-out is bounded. Use `errgroup.WithContext` or equivalent cancellation-aware coordination, and return the first required error while canceling remaining work.

```go
g, ctx := errgroup.WithContext(ctx)
g.Go(func() error { result.Profile, err = b.profile.Get(ctx, id); return err })
g.Go(func() error { result.Balance, err = b.accounts.GetBalance(ctx, id); return err })
if err := g.Wait(); err != nil {
	return View{}, err
}
```

Do not add goroutines for two cheap calls, unbounded lists, or calls with ordering dependencies. Bound concurrency when a request fans out over many resources.

## Dependent calls

Sequence calls when one result determines the next request. Validate ownership at the service that owns the resource; do not infer authorization from IDs returned by a different service. For example, resolve a customer’s allowed account IDs through the account service, then pass those IDs to transfer history if that API supports the filter.

Keep orchestration explicit:

1. validate the client request at the inbound boundary;
2. establish the request deadline and trusted identity context;
3. fetch the minimum required core data;
4. fetch optional enrichments under the remaining budget;
5. shape a stable client response;
6. translate one error at the boundary and record the outcome.

Avoid generic “aggregate everything” helpers. Named use cases make required data, call order, and failure policy reviewable.
