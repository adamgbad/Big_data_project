#!/usr/bin/env bash
# Experiment C: partition-key design and placement (Guide 4).
# Uses keyspace nosql_rf1 (RF 1) so each partition lives on exactly one node.
# KEEP ALL THREE NODES RUNNING: RF 1 has no backup copy.
set -uo pipefail
cd "$(dirname "$0")/.."
export MSYS_NO_PATHCONV=1
PY=$(for p in python3 python; do "$p" -c "" >/dev/null 2>&1 && { echo "$p"; break; }; done)
OUT=evidence/04_partitioning
mkdir -p "$OUT"

echo ">> C0: check 3 x UN"
docker exec cass1 nodetool status | tee "$OUT/c0_status.txt"
[ "$(docker exec cass1 nodetool status | grep -c '^UN')" = "3" ] || { echo "Not all nodes UN. Start stopped nodes with: docker start cass1 cass2 cass3  (wait ~1 min)"; exit 1; }
docker exec cass1 cqlsh -e "DESCRIBE TABLE nosql_rf1.registrations_good; DESCRIBE TABLE nosql_rf1.registrations_bad;" \
  > "$OUT/table_definitions.txt" 2>&1

echo ">> C1: generate and load both RF 1 tables"
"$PY" scripts/generate_data.py
docker exec -i cass1 cqlsh < scripts/seed_rf1_good.cql
docker exec -i cass1 cqlsh < scripts/seed_rf1_bad.cql
{
  echo "## total rows";
  docker exec cass1 cqlsh -e "SELECT count(*) FROM nosql_rf1.registrations_good;"
  docker exec cass1 cqlsh -e "SELECT count(*) FROM nosql_rf1.registrations_bad;"
} 2>&1 | tee "$OUT/row_counts.txt"

echo ">> C2: intended query 'all registrations for event E1' on both designs"
{
  echo "## GOOD design: WHERE event_id = 'E1'"
  docker exec cass1 cqlsh -e "SELECT event_id, seat_no, attendee FROM nosql_rf1.registrations_good WHERE event_id = 'E1' LIMIT 5;"
  echo "## BAD design: WHERE bucket = 'all' AND event_id = 'E1'"
  docker exec cass1 cqlsh -e "SELECT event_id, seat_no, attendee FROM nosql_rf1.registrations_bad WHERE bucket = 'all' AND event_id = 'E1' LIMIT 5;"
} 2>&1 | tee "$OUT/intended_query.txt"

echo ">> C3: rows per partition"
docker exec cass1 cqlsh -e "SELECT event_id, count(*) FROM nosql_rf1.registrations_good GROUP BY event_id;" 2>&1 | tee "$OUT/partition_sizes_good.txt"
docker exec cass1 cqlsh -e "SELECT bucket, count(*) FROM nosql_rf1.registrations_bad GROUP BY bucket;" 2>&1 | tee "$OUT/partition_sizes_bad.txt"
"$PY" -c "
import re, collections
text = open('scripts/seed_rf1_good.cql').read()
rows = set(re.findall(r\"VALUES \('(\w+)', (\d+),\", text))
c = collections.Counter(e for e, s in rows)
print('distinct primary keys per partition (from seed file):', dict(sorted(c.items())), 'total', sum(c.values()))
" | tee "$OUT/partition_sizes_crosscheck.txt"

echo ">> C4: flush and per-node table statistics"
for n in cass1 cass2 cass3; do docker exec $n nodetool flush nosql_rf1; done
for n in cass1 cass2 cass3; do
  echo "== $n =="
  echo "-- registrations_good"; docker exec $n nodetool tablestats nosql_rf1.registrations_good | grep -E "Number of partitions|Space used \(live\)"
  echo "-- registrations_bad";  docker exec $n nodetool tablestats nosql_rf1.registrations_bad  | grep -E "Number of partitions|Space used \(live\)"
done 2>&1 | tee "$OUT/tablestats.txt"

echo ">> C5: placement (getendpoints + token)"
docker inspect -f '{{.Name}} {{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' cass1 cass2 cass3 \
  | sed 's#^/##' | tee "$OUT/node_ips.txt"
: > "$OUT/endpoints_good.txt"
for k in E1 E2 E3 E4 E5 E6; do
  echo "registrations_good key=$k -> $(docker exec cass1 nodetool getendpoints nosql_rf1 registrations_good $k)" | tee -a "$OUT/endpoints_good.txt"
done
echo "registrations_bad key=all -> $(docker exec cass1 nodetool getendpoints nosql_rf1 registrations_bad all)" | tee "$OUT/endpoints_bad.txt"
docker exec cass1 cqlsh -e "SELECT DISTINCT event_id, token(event_id) FROM nosql_rf1.registrations_good;" 2>&1 | tee "$OUT/tokens.txt"
docker exec cass1 cqlsh -e "SELECT DISTINCT bucket, token(bucket) FROM nosql_rf1.registrations_bad;" 2>&1 | tee -a "$OUT/tokens.txt"
docker exec cass1 nodetool status nosql_rf1 2>&1 | tee "$OUT/ownership_rf1.txt"

echo ">> C6: build the placement table for the slides"
"$PY" - "$OUT" <<'PYEOF' | tee "$OUT/placement_table.md"
import re, sys, pathlib
out = pathlib.Path(sys.argv[1])
ip2node = {}
for line in (out / "node_ips.txt").read_text().split("\n"):
    parts = line.split()
    if len(parts) == 2:
        ip2node[parts[1]] = parts[0]
tokens = {}
for m in re.finditer(r"^\s*(\w+)\s*\|\s*(-?\d+)\s*$", (out / "tokens.txt").read_text(), re.M):
    tokens[m.group(1)] = m.group(2)
sizes = {"E1": 30, "E2": 20, "E3": 15, "E4": 25, "E5": 10, "E6": 20, "all": 120}
print("| Table | Partition key | Rows | Token | Replica IP | Node |")
print("|---|---|---|---|---|---|")
for f, table in (("endpoints_good.txt", "registrations_good"), ("endpoints_bad.txt", "registrations_bad")):
    for line in (out / f).read_text().split("\n"):
        m = re.search(r"key=(\w+) -> ([\d.]+)", line)
        if m:
            k, ip = m.groups()
            print(f"| {table} | {k} | {sizes.get(k, '?')} | {tokens.get(k, '?')} | {ip} | {ip2node.get(ip, '?')} |")
PYEOF

echo "Experiment C done. Evidence in $OUT/"
