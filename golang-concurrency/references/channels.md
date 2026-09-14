# Channels

- The sender that owns a channel closes it; receivers never close a shared
  channel.
- Give every producer send a cancellation path so shutdown cannot leave a
  producer blocked.
- Use channels for ownership transfer and make channel closure part of the
  producer/consumer contract.
- On Go 1.27+, use `sync.WaitGroup.Go` for independent goroutines and wait for
  them before the owner returns.
