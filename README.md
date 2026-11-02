# Apache Cassandra group project: event registrations on a 3-node cluster

Big Data Management and Processing, NoSQL group project (Cassandra track).
One running example (event registrations) is used to demonstrate the data model, CRUD,
replication and availability, partition-key placement, and lightweight transactions.

## 1. Environment

| Item | Value |
|---|---|
| Operating system | Windows 11 (Docker Desktop, WSL 2 backend) |
| Docker | Docker 29.2.1, Docker Compose v5.0.2 |
| Database | Apache Cassandra **5.0.9**, open-source edition, image `cassandra:5.0.9` |
| Image digest | `cassandra@sha256:ae4cc2e4b62a5b2a2dd1645ba827cb50c589cc7531bcffe8b8b60ac3b1adc79d` (see `evidence/00_environment/versions.txt`; an earlier pull on another machine recorded `sha256:3ea93337…`, so record your own digest if it differs) |
| cqlsh | 6.2.0 (bundled in the image), CQL spec 3.4.7, native protocol v5 |
| Licence | Apache License 2.0. No paid licence, trial or cloud subscription is needed |
| Shell for scripts | Bash. On Windows use **Git Bash** (not PowerShell, whose `bash` starts WSL) |
| Python | Python 3 (only for `scripts/generate_data.py`) |

### Prerequisites
- At least 16 GB RAM recommended (8 GB is tight); give Docker at least 6 to 8 GB.
- About 5 GB free disk for the image and volumes.
- Docker Desktop running; Git Bash; Python 3.

## 2. Topology

```
            host laptop (cqlsh, scripts)
                    │  127.0.0.1:9042 (CQL, published on cass1 only)
   ┌────────────────┼──────── Docker network "cassnet" ────────────────┐
   │   ┌───────┐  gossip  ┌───────┐  gossip  ┌───────┐                 │
   │   │ cass1 │◄────────►│ cass2 │◄────────►│ cass3 │   dc1 / rack1   │
   │   │ seed  │          │       │          │       │                 │
   │   └───┬───┘          └───┬───┘          └───┬───┘                 │
   │   cass1_data         cass2_data         cass3_data  (volumes)     │
   └───────────────────────────────────────────────────────────────────┘
```

- Three nodes `cass1`, `cass2`, `cass3`, one data centre `dc1`, one rack, seed `cass1`,
  `GossipingPropertyFileSnitch`, private network `cassnet`, one named volume per node.
- Sequential start: `cass2` waits until `cass1` is healthy, `cass3` waits for `cass2` (healthchecks).
- `restart: "no"` so a node stopped for an experiment stays stopped.
- No authentication; the CQL port is bound to `127.0.0.1` only. `.env.example` is a credential
  template with placeholders only; never commit real values (`.env` is git-ignored).

### Resource settings
| Setting | Value | Note |
|---|---|---|
| `MAX_HEAP_SIZE` / `HEAP_NEWSIZE` | 512M / 128M | lowered from the guide's 1G / 256M to fit three JVMs on one laptop |
| `mem_limit` per container | 1200m | observed use about 1.1 of 1.17 GiB per node: tight but stable |

Keyspaces (created by `scripts/00_schema.cql`):
- `nosql_rf3`: `NetworkTopologyStrategy`, `dc1: 3` for CRUD, replication and LWT.
- `nosql_rf1`: `NetworkTopologyStrategy`, `dc1: 1` for the placement experiment only.

## 3. Start, connect, stop, reset

Run everything from the repository root in **Git Bash**.

```bash
# start (first time: 3-6 minutes, nodes start one after another)
docker compose -f config/docker-compose.yml up -d
docker compose -f config/docker-compose.yml ps        # wait for 3 x (healthy)
docker exec cass1 nodetool status                     # expect 3 lines starting with UN

# connect
docker exec -it cass1 cqlsh

# stop (keeps data)
docker compose -f config/docker-compose.yml stop

# clean reset + re-seed (recommended before every experiment / the presentation)
bash scripts/reset.sh
```

> ⚠️ **`scripts/reset.sh` deletes all sample data.** It runs `docker compose down -v`
> (removes the three data volumes), starts the cluster again, waits at most 20 minutes for
> 3 × UN, loads the schema, regenerates the data and loads the 120 RF 3 rows.

If a node was stopped manually (for example for a screenshot), start it again with
`docker start cass3` and wait about a minute until `nodetool status` shows 3 × UN.

## 4. Data

Self-generated, no external dataset. `scripts/generate_data.py` is deterministic: six events
E1–E6 with 30, 20, 15, 25, 10, 20 seats (120 registrations), written to `seed_rf3.cql`,
`seed_rf1_good.cql` and `seed_rf1_bad.cql`.

Main table (query: *list all registrations for event X*):
```sql
CREATE TABLE nosql_rf3.registrations (
  event_id text, seat_no int, attendee text, email text, registered_at timestamp,
  PRIMARY KEY ((event_id), seat_no)          -- partition key event_id, clustering column seat_no
) WITH CLUSTERING ORDER BY (seat_no ASC);
```

## 5. Experiments: scripts, evidence and expected results

Run in this order after `bash scripts/reset.sh`. Each script checks that all three nodes are UN
first and writes its full output to `evidence/`. Each evidence folder has a `notes.md` with
configuration, action, expected result, observed result and interpretation.

| Part | Run | Evidence | Expected result |
|---|---|---|---|
| 2 Environment | `bash scripts/env_check.sh` | `evidence/00_environment/` | 5.0.9, 3 × UN, one schema version, write via cass1 read via cass3, no log errors |
| 4 CRUD | `bash scripts/crud_run.sh` | `evidence/02_crud/` | every step verified; upsert in steps 4–5; query on `attendee` refused (ALLOW FILTERING) |
| 5B Replication | `bash scripts/b_replication.sh` | `evidence/03_replication/` | cass3 DN; LOCAL_QUORUM read/write OK; ALL read Unavailable (3 required, 2 alive); after restart ALL read returns `during_failure` |
| 5C Partitioning | `bash scripts/c_partitioning.sh` | `evidence/04_partitioning/` | good table 6 partitions (10–30 rows) on several nodes; bad table 1 partition of 120 rows on one node; `placement_table.md` |
| 5D LWT | `bash scripts/d_lwt.sh` | `evidence/05_lwt/` | client A `[applied] True`, client B `False` with owner Alice, final owner Alice; plain INSERT lets Bob overwrite |

Screenshots used in the slides are in `evidence/screenshots/`; a recording of the replication run
is `evidence/03_replication/recording_b_replication.mp4`.

**Running the LWT test by hand (two terminals):** open `docker exec -it cass1 cqlsh` and `docker exec -it cass2 cqlsh`,
run `CONSISTENCY LOCAL_QUORUM;` and `SERIAL CONSISTENCY LOCAL_SERIAL;` in both, then run the
`INSERT … IF NOT EXISTS` for Alice (left) and then for Bob (right) with a **new** event id each time.

## 6. Repository layout

```
README.md               this file
.env.example            credential template (placeholders only)
config/docker-compose.yml
scripts/                schema, generator, seed files, CRUD, experiment scripts, reset
evidence/               outputs + notes.md per experiment, screenshots, recording
slides/                 Cassandra_Full_Presentation.pptx (all six parts, 27 slides)
video/                  presentation recording(s)
Documentations/         task guide and assignment notes
```

## 7. Limitations of this setup
- Three containers on one computer show **process failure**, not survival of losing the machine.
- Results say nothing about production-scale performance.
- Memory per node is close to its limit; if a container exits with code 137, give Docker more memory
  or raise `mem_limit`.

## 8. Contributions

| Member | What they did | Evidence |
|---|---|---|
| Ádám Guba | Environment: 3-node Docker Compose cluster (pinned 5.0.9 image, healthchecks, memory settings), version and image digest record, schema, first version of `reset.sh` and of the replication experiment (B). Part 1 introduction slides and recording | `config/docker-compose.yml`, `scripts/00_schema.cql`, `.env.example`, `evidence/00_environment/versions.txt`, slides 1–8 |
| Sun Thong | Deterministic data generator and seed files; CRUD script (all steps including upsert) | `scripts/generate_data.py`, `scripts/seed_*.cql`, `scripts/crud.cql` |
| Chen Yuqi | Completed `reset.sh` (data-deletion warning, wait loop, re-seeding); environment check script; experiments C (partitioning) and D (lightweight transactions); CRUD run results and ALLOW FILTERING evidence; `notes.md` for every experiment; screenshots; README; slides for Parts 2–6 | `scripts/reset.sh`, `scripts/env_check.sh`, `evidence/00_environment/`, `scripts/c_partitioning.sh`, `scripts/d_*.cql`, `scripts/d_lwt.sh`, `scripts/crud_run.sh`, `evidence/02_crud/`, `evidence/04_partitioning/`, `evidence/05_lwt/`, `evidence/*/notes.md`, `evidence/screenshots/`, `README.md`, `slides/Cassandra_Full_Presentation.pptx` (slides 9–27) |

## 9. Sources
- Lakshman, A. & Malik, P. (2010). Cassandra: a decentralized structured storage system. *ACM SIGOPS OSR* 44(2).
- Apache Cassandra 5.0 documentation: architecture, CQL DDL/DML, hints, read repair, cqlsh, nodetool. https://cassandra.apache.org/doc/stable/
- Apache Cassandra download and licence. https://cassandra.apache.org/_/download.html
- Course handout: NoSQL Group Project, Big Data Management and Processing.
