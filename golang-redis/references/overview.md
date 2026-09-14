# Go Redis

Use this skill when implementing Redis access with github.com/redis/go-redis/v9.
Read the calling use case, key ownership, expiration policy, and failure
behavior before adding commands. Reuse the shared client from pkg/cache; do
not create a client per request or per repository.
