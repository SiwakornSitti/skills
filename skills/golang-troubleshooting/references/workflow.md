# Diagnostic workflow

- Capture the exact symptom, input, environment, timing, and first relevant error.
- Reproduce it with the smallest reliable command or test before changing code.
- Form one falsifiable hypothesis, add the smallest useful observation, and update it from evidence.
- Trace the full request or goroutine path to the root cause; do not stop at the first symptom.
- Fix the cause, explain why it works, and add a regression check before cleanup or refactoring.
