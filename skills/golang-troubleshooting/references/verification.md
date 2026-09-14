# Verification

- Add a failing regression test or a repeatable diagnostic command before declaring the issue fixed.
- Re-run the smallest reproducer, then the package and repository checks that cover the affected path.
- Verify the fix does not add races, leaks, unbounded retries, unsafe logs, or a new timeout failure.
- Record unresolved environmental blockers separately from code findings.
