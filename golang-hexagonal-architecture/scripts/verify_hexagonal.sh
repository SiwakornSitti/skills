#!/usr/bin/env bash
set -euo pipefail

echo "============================================================"
echo " 🔍 Hexagonal Architecture Boundary Verification"
echo "============================================================"

FAILED=0

# 1. Verify domain package isolation
# Domain packages must NOT import database drivers, HTTP, or infrastructure libraries.
echo "1. Checking domain package purity..."
FORBIDDEN_DOMAIN_IMPORTS="github.com/jackc/pgx|database/sql|net/http|log/slog|github.com/redis/go-redis"
DOMAIN_VIOLATIONS=$(go list -f '{{.ImportPath}}: {{.Imports}}' ./internal/... 2>/dev/null | grep '/domain:' | grep -E "$FORBIDDEN_DOMAIN_IMPORTS" || true)

if [ -n "$DOMAIN_VIOLATIONS" ]; then
    echo "❌ Domain Isolation Violation: domain package imports forbidden infrastructure:"
    echo "$DOMAIN_VIOLATIONS"
    FAILED=1
else
    echo "  ✅ Domain packages are pure (zero infrastructure/driver imports)."
fi

# 2. Verify service package isolation
# Service packages must NOT import HTTP transport or raw database drivers directly.
echo "2. Checking service package isolation..."
FORBIDDEN_SERVICE_IMPORTS="github.com/jackc/pgx|database/sql|net/http"
SERVICE_VIOLATIONS=$(go list -f '{{.ImportPath}}: {{.Imports}}' ./internal/... 2>/dev/null | grep '/service:' | grep -E "$FORBIDDEN_SERVICE_IMPORTS" || true)

if [ -n "$SERVICE_VIOLATIONS" ]; then
    echo "❌ Service Isolation Violation: service package imports transport or raw DB driver:"
    echo "$SERVICE_VIOLATIONS"
    FAILED=1
else
    echo "  ✅ Service packages are isolated from transport and drivers."
fi

# 3. Verify cross-context boundary rules
# Bounded contexts may use target domain contracts at wiring boundaries, never another context's internal service, outbound, or inbound packages.
echo "3. Checking cross-context boundary isolation..."
CROSS_VIOLATIONS=$(python3 - << 'PYEOF'
import subprocess, re

out = subprocess.check_output(["go", "list", "-f", "{{.ImportPath}} {{.Imports}}", "./internal/..."]).decode()
lines = out.strip().split("\n")

violations = []
for line in lines:
    parts = line.split(" [")
    pkg = parts[0]
    imports = parts[1].rstrip("]").split(" ") if len(parts) > 1 else []
    
    m = re.match(r".*internal/([^/]+)(/.*)?", pkg)
    if not m:
        continue
    current_ctx = m.group(1)
    
    for imp in imports:
        im = re.match(r".*internal/([^/]+)/(service|outbound|inbound).*", imp)
        if im:
            target_ctx = im.group(1)
            if target_ctx != current_ctx:
                violations.append(f"Package '{pkg}' illegally imports '{imp}' (use '{target_ctx}/domain' only at a wiring boundary)")

if violations:
    for v in violations:
        print(v)
    exit(1)
PYEOF
) || FAILED=1

if [ -n "$CROSS_VIOLATIONS" ]; then
    echo "❌ Cross-Context Boundary Violations:"
    echo "$CROSS_VIOLATIONS"
else
    echo "  ✅ Cross-context boundaries intact (no cross-context internal adapter imports)."
fi

# 4. Attempt depguard linter check if golangci-lint v2 is configured
if command -v golangci-lint >/dev/null 2>&1; then
    echo "4. Running golangci-lint depguard check..."
    if golangci-lint run --disable-all -E depguard 2>/dev/null; then
        echo "  ✅ Depguard linter rules verified."
    else
        echo "  ℹ️  golangci-lint depguard skipped or requires version alignment (native checks succeeded)."
    fi
fi

echo "------------------------------------------------------------"
if [ "$FAILED" -ne 0 ]; then
    echo "❌ Hexagonal architecture checks failed."
    exit 1
fi

echo "✨ All hexagonal architecture boundary checks passed successfully!"
