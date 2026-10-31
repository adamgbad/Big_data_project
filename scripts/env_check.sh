#!/usr/bin/env bash
# Environment evidence (Part 2 / Guide 1, steps 1.5-1.8).
# Run after scripts/reset.sh. Writes to evidence/00_environment/.
set -uo pipefail
cd "$(dirname "$0")/.."
export MSYS_NO_PATHCONV=1
OUT=evidence/00_environment
mkdir -p "$OUT"

echo ">> versions.txt"
{
  echo "## host";            docker --version; docker compose version
  echo; echo "## nodetool version"; docker exec cass1 nodetool version
  echo; echo "## image digest";     docker image inspect cassandra:5.0.9 --format '{{index .RepoDigests 0}}'
  echo; echo "## cqlsh version";    docker exec cass1 cqlsh -e 'SHOW VERSION'
} > "$OUT/versions.txt" 2>&1

echo ">> cluster_status.txt (nodetool status + describecluster)"
{
  echo "## docker compose ps"; docker compose -f config/docker-compose.yml ps
  echo; echo "## nodetool status"; docker exec cass1 nodetool status
  echo; echo "## nodetool describecluster"; docker exec cass1 nodetool describecluster
} > "$OUT/cluster_status.txt" 2>&1

echo ">> smoke_test.txt (write via cass1, read via cass3)"
{
  docker exec -i cass1 cqlsh <<'EOF'
CREATE KEYSPACE IF NOT EXISTS smoke WITH replication = {'class': 'NetworkTopologyStrategy', 'dc1': 3};
CREATE TABLE IF NOT EXISTS smoke.t (id int PRIMARY KEY, v text);
INSERT INTO smoke.t (id, v) VALUES (1, 'hello');
EOF
  echo "## SELECT through cass3:"
  docker exec cass3 cqlsh -e "SELECT * FROM smoke.t;"
  docker exec cass1 cqlsh -e "DROP KEYSPACE smoke;"
} > "$OUT/smoke_test.txt" 2>&1

echo ">> resources.txt (memory, disk, logs)"
{
  echo "## docker stats (limit per container: 1200 MiB)"; docker stats --no-stream cass1 cass2 cass3
  echo; echo "## docker system df"; docker system df
  echo; echo "## errors in last 50 log lines of each node"
  for n in cass1 cass2 cass3; do
    echo "-- $n"; docker logs --tail 50 "$n" 2>&1 | grep -iE "error|exception" || echo "no errors found"
  done
} > "$OUT/resources.txt" 2>&1

echo "Done. Files:"; ls -1 "$OUT"
