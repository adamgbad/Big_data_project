set -euo pipefail

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
echo "Cluster ready and schema loaded."