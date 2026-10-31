# Experiment C: partition-key design and placement (Part 5C)

| Field | Record |
|---|---|
| Configuration | 3 nodes all UN, keyspace `nosql_rf1` (dc1: 1), tables `registrations_good` (PK `((event_id), seat_no)`) and `registrations_bad` (PK `((bucket), event_id, seat_no)`, bucket = 'all') |
| Action | `bash scripts/c_partitioning.sh`: load 120 rows into each, run the intended query, count rows per partition, flush + `tablestats`, `getendpoints` and `token()` per key |
| Expected result | Good: 6 partitions of 10–30 rows on more than one node. Bad: 1 partition of 120 rows on one node |
| Observed result | `row_counts.txt` 120 / 120. `partition_sizes_good.txt` E1 30, E2 20, E3 15, E4 25, E5 10, E6 20 (cross-checked from the seed file). `partition_sizes_bad.txt` all 120. `placement_table.md`: E1, E3, E6 → cass1; E2, E4, E5 → cass2; all → cass1. `tablestats.txt`: cass1 3 good + 1 bad partition, cass2 3 good, cass3 none. `ownership_rf1.txt`: cass3 owns 35.7 % of the ring |
| Interpretation | The partition key is hashed to a token and the token decides the node; clustering columns only order rows. The constant key concentrates all data and requests on one node (hotspot). With only six keys the spread is uneven (cass3 received none), so more keys reduce but do not remove hotspot risk. `getendpoints` shows the replica owner, not the coordinator |
