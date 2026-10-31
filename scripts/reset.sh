#!/usr/bin/env bash
# Reset the 3-node Cassandra lab to a clean, seeded state.
#
# WARNING: 'docker compose down -v' DELETES all Cassandra data volumes
#          (cass1_data, cass2_data, cass3_data). All sample data is lost
#          and re-created from scripts/generate_data.py.
#
# Usage (from any directory):  bash scripts/reset.sh
set -euo pipefail

cd "$(dirname "$0")/.."            # always run from the repository root
export MSYS_NO_PATHCONV=1           # Git Bash on Windows: do not rewrite paths
PY=$(for p in python3 python; do "$p" -c "" >/dev/null 2>&1 && { echo "$p"; break; }; done)
COMPOSE="docker compose -f config/docker-compose.yml"

echo ">> Removing containers and data volumes ..."
$COMPOSE down -v
echo ">> Starting cass1 -> cass2 -> cass3 (sequential, 3-6 minutes) ..."
$COMPOSE up -d

# Bounded readiness check: at most 120 x 10 s = 20 minutes
ready=0
for i in $(seq 1 120); do
  n=$(docker exec cass1 nodetool status 2>/dev/null | grep -c '^UN' || true)
  if [ "$n" = "3" ]; then ready=1; break; fi
  sleep 10
done
[ "$ready" = "1" ] || { echo "Cluster not ready after 20 minutes"; exit 1; }

echo ">> Loading schema ..."
docker exec -i cass1 cqlsh < scripts/00_schema.cql

echo ">> Generating and loading RF 3 seed data ..."
"$PY" scripts/generate_data.py
docker exec -i cass1 cqlsh < scripts/seed_rf3.cql
docker exec cass1 cqlsh -e "SELECT count(*) FROM nosql_rf3.registrations;"

echo "Cluster ready: 3 nodes UN, schema loaded, 120 rows in nosql_rf3.registrations."
