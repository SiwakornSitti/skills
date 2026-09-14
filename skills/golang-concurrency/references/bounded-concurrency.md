# Bounded concurrency

- Bound fan-out with a fixed worker count or buffered semaphore. Do not start
  one goroutine per unbounded input.
- Bound input, queue capacity, downstream calls, and any shared resource the
  workers consume.
- Use a semaphore for simple bounded parallelism. Use a worker pool when work
  needs queueing, worker reuse, or explicit backpressure.

```go
func Run(ctx context.Context, jobs []Job, workers int) error {
    if workers < 1 {
        workers = 1
    }
    workerCtx, cancel := context.WithCancel(ctx)
    defer cancel()
    queue := make(chan Job)
    errs := make(chan error, 1)
    var wg sync.WaitGroup

    for range workers {
        wg.Go(func() {
            for {
                select {
                case <-workerCtx.Done():
                    return
                case job, ok := <-queue:
                    if !ok {
                        return
                    }
                    if err := process(workerCtx, job); err != nil {
                        select { case errs <- err: default: }
                        cancel()
                        return
                    }
                }
            }
        })
    }

send:
    for _, job := range jobs {
        select {
        case queue <- job:
        case <-workerCtx.Done():
            break send
        }
    }
    close(queue)
    wg.Wait()
    select {
    case err := <-errs:
        return err
    case <-ctx.Done():
        return ctx.Err()
    default:
        return nil
    }
}
```
