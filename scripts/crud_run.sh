#!/usr/bin/env bash
# Part 4: CRUD demonstration + what Cassandra refuses (Guide 2, steps 2.4-2.5).
set -uo pipefail
cd "$(dirname "$0")/.."
export MSYS_NO_PATHCONV=1
OUT=evidence/02_crud
mkdir -p "$OUT"

echo ">> CRUD script"
docker exec -i cass1 cqlsh < scripts/crud.cql 2>&1 | tee "$OUT/crud_output.txt"

echo ">> Query on a non-key column (expected: InvalidRequest, needs ALLOW FILTERING)"
docker exec cass1 cqlsh -e "SELECT * FROM nosql_rf3.registrations WHERE attendee = 'attendee_E1_001';" \
  2>&1 | tee "$OUT/allow_filtering_error.txt"
echo "Done. Evidence in $OUT/"
