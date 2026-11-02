set -euo pipefail

cd "$(dirname "$0")/.."
export MSYS_NO_PATHCONV=1
PY=$(for p in python3 python; do "$p" -c "" >/dev/null 2>&1 && { echo "$p"; break; }; done)
COMPOSE="docker compose -f config/docker-compose.yml"

$COMPOSE down -v
$COMPOSE up -d

ready=0
for i in $(seq 1 120); do
  n=$(docker exec cass1 nodetool status 2>/dev/null | grep -c '^UN' || true)
  if [ "$n" = "3" ]; then ready=1; break; fi
  sleep 10
done
[ "$ready" = "1" ] || { echo "Cluster not ready after 20 minutes"; exit 1; }

docker exec -i cass1 cqlsh < scripts/00_schema.cql

"$PY" scripts/generate_data.py
docker exec -i cass1 cqlsh < scripts/seed_rf3.cql
docker exec cass1 cqlsh -e "SELECT count(*) FROM nosql_rf3.registrations;"