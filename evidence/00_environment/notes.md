# Environment check (Part 2)

| Field | Record |
|---|---|
| Configuration | Cassandra 5.0.9 (`cassandra:5.0.9`), 3 nodes cass1–cass3, dc1/rack1, heap 512M, limit 1200 MiB per container, Windows 11 + Docker 29.2.1 |
| Action | `bash scripts/reset.sh`, then `bash scripts/env_check.sh` |
| Expected result | 3 × UN, one schema version, a row written via cass1 is readable via cass3, no errors in logs |
| Observed result | `cluster_status.txt`: 3 × UN, one schema version `83018f0f…` listing all three IPs. `smoke_test.txt`: `1 \| hello` read through cass3. `resources.txt`: no errors; memory 1.11–1.14 GiB of 1.17 GiB per node. `versions.txt`: ReleaseVersion 5.0.9, digest recorded |
| Interpretation | The topology is complete and replicating. Memory is the main constraint on one laptop (about 95 % of the container limit) |

Files: `versions.txt`, `cluster_status.txt`, `smoke_test.txt`, `resources.txt`.
Screenshots: `../screenshots/01_docker_desktop.png`, `02_compose_ps.png`, `03_nodetool_status.png`.
