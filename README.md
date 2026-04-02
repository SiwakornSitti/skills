# Skills Repository

This repository contains reusable skills and configurations for various tech stacks.

## Getting Started

To ensure code quality, we use the `pre-commit` framework to run linters and tests before every commit.

### Setup

1. [Install `pre-commit`](https://pre-commit.com/#install) on your local machine.
2. Run the following command from the root of this repository:

   ```bash
   pre-commit install
   ```

This will automatically configure Git hooks to run `make lint` and `make test` for the Go modules before allowing a commit.
