# TestMain and lifecycle

- Package-level `TestMain` may create the required pool/client, wait for readiness, apply setup, run `m.Run`, close clients/pools, and terminate owned containers.
- Use bounded startup/teardown contexts and report setup errors before tests run.
- Keep setup local to the package until repeated duplication justifies a shared harness.
- Apply the same lifecycle rules to Postgres, Redis, and any external adapter.
