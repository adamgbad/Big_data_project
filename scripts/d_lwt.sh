#!/usr/bin/env bash
# Experiment D: lightweight transaction, two clients claim the same seat (Guide 5).
# Requires all 3 nodes UN. Every run uses a fresh event id, so it can be repeated.
set -uo pipefail
cd "$(dirname "$0")/.."
export MSYS_NO_PATHCONV=1
OUT=evidence/05_lwt
mkdir -p "$OUT"
run() { sed "s/__EVENT__/$2/g" "scripts/$1" | docker exec -i "$3" cqlsh 2>&1; }

echo ">> D0: check 3 x UN"
docker exec cass1 nodetool status | tee "$OUT/d0_status.txt"
[ "$(docker exec cass1 nodetool status | grep -c '^UN')" = "3" ] || { echo "Not all nodes UN. Start stopped nodes with: docker start cass1 cass2 cass3  (wait ~1 min)"; exit 1; }

STAMP=$(date +%s)
EV="demo-run-$STAMP"
echo "event id used: $EV" | tee "$OUT/d_event_id.txt"

echo ">> D1: controlled order  A (cass1) -> B (cass2) -> final read (cass3)"
run d_client_a.cql   "$EV" cass1 | tee "$OUT/d_client_a.txt"
run d_client_b.cql   "$EV" cass2 | tee "$OUT/d_client_b.txt"
run d_final_read.cql "$EV" cass3 | tee "$OUT/d_final_read.txt"

echo ">> D2: contrast with ordinary upsert"
run d_plain_upsert.cql "demo-plain-$STAMP" cass1 | tee "$OUT/d_plain_upsert.txt"

echo ">> D3 (optional): simultaneous attempts"
RACE="demo-race-$STAMP"
( run d_client_a.cql "$RACE" cass1 > "$OUT/race_a.txt" ) &
( run d_client_b.cql "$RACE" cass2 > "$OUT/race_b.txt" ) &
wait
run d_final_read.cql "$RACE" cass3 > "$OUT/race_final.txt"
grep -hE "True|False" "$OUT/race_a.txt" "$OUT/race_b.txt" | tee "$OUT/race_summary.txt"
cat "$OUT/race_final.txt"

echo "Experiment D done. Evidence in $OUT/"
