# Numbers and resources

- Check bounds before narrowing integer conversions; Go conversions can truncate or wrap without an error.
- Compare computed floating-point values with a domain-appropriate tolerance, not `==`.
- Guard integer division against zero and define how non-finite floating-point results are handled.
- Scope `defer` to one resource-lifetime function; a defer inside a large loop holds resources until the outer function returns.
- Handle close and flush errors when they can lose data; use [golang-error-handling](../../golang-error-handling/SKILL.md) for propagation.
