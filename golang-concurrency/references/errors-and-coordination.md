# Errors and coordination

- Propagate the first operational error to the owner and cancel sibling work
  when continued processing is unsafe.
- Distinguish an operational error that caused cancellation from caller
  cancellation; return the most useful cause to the owner.
- Log and continue only when the work is explicitly best-effort and the loss is
  acceptable.
- Make the owner collect worker completion and errors after closing input.
