# Configuration Management

This document outlines the best practices for managing application configuration in this project.

## 1. Principles

- **The Twelve-Factor App:** Configuration that varies between deployments (e.g., development, staging, production) **must** be stored in environment variables, following the Twelve-Factor App methodology. This ensures:
  - **Strict separation of config from code:** Config varies substantially across deploys, code does not.
  - **Environment Agnostic Code:** The same compiled binary can run in Dev, QA, and Prod just by swapping the environment variables.
  - **No Configuration Files in Container:** Do not bake config files into the Docker image; instead, rely on Kubernetes ConfigMaps or Secrets to inject the environment at runtime.
- **Fail Fast:** As defined in [Web Server Configuration](web_server.md), validate all required configuration parameters during application startup. If a required variable is missing or malformed, the application must crash immediately.
- **No Hardcoded Secrets:** Never hardcode passwords, API keys, or sensitive URLs in the source code or default configuration files.

## 2. Configuration Tools

- **Preferred Libraries:** Use libraries like `spf13/viper`, `kelseyhightower/envconfig`, or `ilyakaznacheev/cleanenv` to parse and bind configuration data directly into structured Go structs.
- **Type Safety:** Always map environment variables to strongly typed Go structs (e.g., `int` for ports, `time.Duration` for timeouts) rather than constantly calling `os.Getenv()` throughout the codebase.
- **Auto-Reloading (Hot Reload):** If your application uses configuration files (e.g., `.yaml` or `.json` alongside env vars) and requires dynamic updates without restarting, use tools like `viper.WatchConfig()`. Ensure that components relying on these dynamic configs are built in a thread-safe manner (e.g., using `sync.RWMutex` or atomic operations) when reading the new values.

## 3. Local Development (`.env`)

- **`.env` Files:** Use `.env` files strictly for local development to simulate production environment variables. Libraries like `joho/godotenv` can be used to load these locally.
- **Git Ignore:** The `.env` file **must** be added to `.gitignore` to prevent accidentally committing local secrets to the repository.
- **`.env.example`:** Maintain an up-to-date `.env.example` or `.env.template` file in the repository containing all required variables with safe, dummy values to help new developers onboard quickly.

## 4. Structuring Configuration

Group configuration logically within your Go structs:

```go
type Config struct {
 App      AppConfig
 Database DatabaseConfig
 Redis    RedisConfig
}

type AppConfig struct {
 Port         int           `env:"APP_PORT" env-default:"8080"`
 ReadTimeout  time.Duration `env:"APP_READ_TIMEOUT" env-default:"5s"`
 WriteTimeout time.Duration `env:"APP_WRITE_TIMEOUT" env-default:"10s"`
}

type DatabaseConfig struct {
 DSN          string        `env:"DB_DSN" env-required:"true"`
 MaxOpenConns int           `env:"DB_MAX_OPEN_CONNS" env-default:"25"`
}
```
