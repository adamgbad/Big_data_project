#!/usr/bin/env bash
# Experiment B: replication and availability (Guide 3).
# RF 3, stop cass3 -> LOCAL_QUORUM works, ALL read fails -> restore -> ALL read works.
# Requires: all 3 nodes UN and schema loaded (run scripts/reset.sh first).
set -uo pipefail
cd "$(dirname "$0")/.."
export MSYS_NO_PATHCONV=1
OUT=evidence/03_replication
mkdir -p "$OUT"

status_count() { docker exec cass1 nodetool status 2>/dev/null | grep -c "^$1" || true; }

echo ">> B0: clean start (delete old test row, check 3 x UN)"
docker exec cass1 cqlsh -e "DELETE FROM nosql_rf3.registrations WHERE event_id = 'B-TEST';"
docker exec cass1 nodetool status | tee "$OUT/b0_status_before.txt"
[ "$(status_count UN)" = "3" ] || { echo "Not all nodes UN. Start stopped nodes with: docker start cass1 cass2 cass3  (wait ~1 min), or run scripts/reset.sh"; exit 1; }
docker exec cass1 cqlsh -e "DESCRIBE KEYSPACE nosql_rf3;" | grep -i replication | tee "$OUT/b0_keyspace_rf3.txt"

echo ">> B1: seed at CONSISTENCY ALL"
docker exec -i cass1 cqlsh < scripts/b1_seed.cql 2>&1 | tee "$OUT/b1_seed.txt"
docker exec cass1 nodetool getendpoints nosql_rf3 registrations B-TEST | tee "$OUT/b1_endpoints.txt"
docker inspect -f '{{.Name}} {{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' cass1 cass2 cass3 | tee "$OUT/node_ips.txt"

echo ">> B2: stop cass3 and wait for DN (max 60 s)"
date '+stopped cass3 at %H:%M:%S' | tee "$OUT/b2_timeline.txt"
docker stop cass3
for i in $(seq 1 12); do [ "$(status_count DN)" -ge 1 ] && break; sleep 5; done
date '+DN visible at %H:%M:%S' | tee -a "$OUT/b2_timeline.txt"
docker exec cass1 nodetool status | tee "$OUT/b2_status_down.txt"

echo ">> B2: LOCAL_QUORUM read/write/read, then ALL read (expected to fail)"
docker exec -i cass1 cqlsh < scripts/b2_failure.cql 2>&1 | tee "$OUT/b2_failure.txt"

echo ">> B3: restart cass3 and wait for 3 x UN (max 4 min)"
docker start cass3
for i in $(seq 1 24); do [ "$(status_count UN)" = "3" ] && break; sleep 10; done
date '+3 x UN again at %H:%M:%S' | tee -a "$OUT/b2_timeline.txt"
docker exec cass1 nodetool status | tee "$OUT/b3_status_restored.txt"
sleep 20   # give hinted handoff a moment to replay

echo ">> B3: hint delivery"
{
  echo "## nodetool statushandoff (cass1)"; docker exec cass1 nodetool statushandoff
  echo; echo "## tpstats hint lines (cass1)"; docker exec cass1 nodetool tpstats | grep -i hint
  echo; echo "## cass1 log (hints)"; docker logs --since 15m cass1 2>&1 | grep -i hint | tail -20
  echo; echo "## cass3 log (hints/handoff)"; docker logs --since 15m cass3 2>&1 | grep -iE "hint|handoff" | tail -20
} 2>&1 | tee "$OUT/b3_hints.txt"

echo ">> B3: ALL read after recovery"
docker exec -i cass1 cqlsh < scripts/b3_recovery.cql 2>&1 | tee "$OUT/b3_recovery.txt"

echo ">> B4: clean up test row"
docker exec cass1 cqlsh -e "DELETE FROM nosql_rf3.registrations WHERE event_id = 'B-TEST';"
echo "Experiment B done. Evidence in $OUT/"
