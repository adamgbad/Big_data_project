# Experiment B: replication and availability (Part 5B)

| Field | Record |
|---|---|
| Configuration | 3 nodes, keyspace `nosql_rf3` (`NetworkTopologyStrategy`, dc1: 3), client always connected to cass1 |
| Action | `bash scripts/b_replication.sh`: seed `B-TEST` at ALL → `docker stop cass3` → LOCAL_QUORUM read/write/read → ALL read → `docker start cass3` → hints → ALL read → delete test row |
| Expected result | LOCAL_QUORUM read and write succeed with one node down; ALL read fails with Unavailable; after restart an ALL read returns the value written during the failure |
| Observed result | `b0_status_before.txt` 3 × UN. `b1_seed.txt` before_failure; `b1_endpoints.txt` all three IPs. `b2_timeline.txt` cass3 DN 5 s after stop. `b2_failure.txt`: B2a before_failure, B2b write OK, B2c during_failure, B2d `Unavailable … required_replicas: 3, alive_replicas: 2`. `b3_status_restored.txt` 3 × UN about 20 s after start. `b3_hints.txt`: `Finished hinted handoff … to endpoint /172.19.0.4` (cass3). `b3_recovery.txt` ALL read returns during_failure |
| Interpretation | RF sets the number of copies (3), CL the number of replies needed (QUORUM 2, ALL 3). With 2 replicas alive QUORUM is possible, ALL is not. Hinted handoff delivered the missed write to cass3. An ALL read may trigger read repair, so it shows the replicas agree now, not that they were already in sync. One laptop shows process failure only |

Note: `b3_recovery.cql` additionally writes `after_recovery` at ALL to show writes at ALL work again.
Screenshot: `../screenshots/04_status_DN.png`. Recording: `recording_b_replication.mp4`.
