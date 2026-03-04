#!/bin/bash
set -e

# Run migrations (optional but recommended)
/app/bin/migrate

# Start the Phoenix server
exec /app/bin/server