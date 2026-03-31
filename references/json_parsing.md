# JSON Parsing

- **Avoid `encoding/json` (v1):** Use high-performance alternatives like `bytedance/sonic`, `json-iterator/go`, or the proposed `encoding/json/v2` (if applicable) to avoid the performance overhead of the standard library's v1 reflection-based implementation.
- **Choices:**
  - **`bytedance/sonic`:** A high-performance, JIT-based JSON library. Recommended for environments where high throughput and low latency are critical.
  - **`json-iterator/go`:** A drop-in replacement for the standard library that provides significantly better performance.
- **Performance:** For APIs with high throughput or large JSON payloads, reflection-based parsing in v1 can become a bottleneck.
- **Configuration:** When using alternatives like `json-iterator`, ensure it is configured for compatibility if needed (e.g., `ConfigCompatibleWithStandardLibrary`).
