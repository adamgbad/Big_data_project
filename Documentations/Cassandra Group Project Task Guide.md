# Cassandra Group Project: Task Guide

**Big Data Management and Processing**  
*Date:* Oct 19, 2026 • *@Augsut*  
*Document:* Cassandra Group Project: Task Guide (中文 / English / Magyar)

---

## Section 2 (English): Team Task Allocation Guide

The three members split the work by risk:
- **Member A** owns the environment and availability experiments.
- **Member B** owns the data model, partitioning, and transactions.
- **Member C** (the undergraduate) owns the introduction, basic operations, and background material.

The talk is 25 minutes plus about 3 minutes of questions. Replace A, B and C with real names.

### 1. Allocation table

| Member | Presentation parts | Time | Experiments | Main deliverables |
| :--- | :--- | :--- | :--- | :--- |
| **A** | Part 2 Setup;<br>Part 5B Replication and availability;<br>Part 6 Conclusion | 3 + 4 + 1 = **8 min** | Environment;<br>experiment B | `docker-compose.yml`, `README`, `reset.sh`, evidence for B |
| **B** | Part 3 Data model;<br>Part 5C Partitioning;<br>Part 5D Lightweight transactions | 2 + 3 + 4 = **9 min** | Data model;<br>experiments C and D | `schema.cql`, scripts and evidence for C and D |
| **C** | Part 1 Introduction;<br>Part 4 Basic operations | 3 + 5 = **8 min** | CRUD;<br>data generator;<br>background research | `generate_data.py`, `crud.cql`, reference list, evidence filing |

The total is 8 + 9 + 8 = **25 minutes**, matching the handout.

---

### 2. Task checklist per member

#### Member A: environment and replication
- [ ] Pin the image version (for example `cassandra:5.0.9`, never `latest`) and record the version and digest
- [ ] Write the 3-node `docker-compose.yml` with sequential startup, healthchecks and a heap limit
- [ ] Confirm all 3 nodes show `UN` in `nodetool status` and record the real data-centre name
- [ ] Write `reset.sh` (wipe and re-seed) and the start, stop and reset steps in the `README`
- [ ] Run experiment B and save commands, output and screenshots
- [ ] Help B and C get the environment running on their own computers
- [ ] Prepare and present Part 2, Part 5B and Part 6

#### Member B: data model, partitioning and transactions
- [ ] Design the `registrations` table and explain the partition key, clustering column and the query it serves
- [ ] Run experiment C: good versus poor design, partition-size counts, and the `nodetool getendpoints` placement table
- [ ] Run experiment D: two clients claim the same seat with `IF NOT EXISTS`
- [ ] Save evidence for each experiment with expected and observed results
- [ ] Prepare and present Part 3, Part 5C and Part 5D

#### Member C: introduction, basic operations and background
- [ ] Read the sources and write Part 1: background (with a reliable citation), core features, at least one strength and one limitation
- [ ] Write the data generator `generate_data.py` that creates registrations for several events
- [ ] Write the CRUD scripts and verify the state after every step; add one useful query beyond CRUD (for example, list all registrations for one event)
- [ ] Organise the evidence folder and slide formatting, with sources at the end of the slides
- [ ] Prepare and present Part 1 and Part 4; be able to explain upsert and the difference between a partition key and a clustering column

> **Tip:** A and B give C script skeletons first. C then runs them, captures the output and writes the explanation, which is easier than starting from nothing.

> 💡 **Megjegyzés / Kiegészítés a projektleírás alapján (Part 1 - Történeti hivatkozás):**  
> A projektleírás (`NoSQL Group Project - Hungarian.md`, 170. sor) kifejezetten megköveteli egy megbízható forrás idézését a Cassandra kialakulásához és céljához: *"Cite a reliable source for historical claims"*.  
> **Javasolt forrás a bemutatóhoz és a diákhoz:**  
> Lakshman, A., & Malik, P. (2010). *Cassandra: a decentralized structured storage system.* ACM SIGOPS Operating Systems Review, 44(2), 35-40. (Ez a hivatalos publikáció a Cassandra alapjairól, bemutatva az Amazon Dynamo particionálási/replikációs modelljét és a Google Bigtable oszloptárolási elvét).


---

### 3. Collaboration rules

1. **Shared Git repository:** Use one shared Git repository with `slides/`, `config/`, `scripts/`, `evidence/` and `README.md`. Each person commits to their own folders, and the history shows each person's contribution.
2. **Experiment template:** Record every experiment with one template: configuration, action, expected result, observed result, interpretation.
3. **Clean state:** Start every experiment from a clean state: all 3 nodes `UN` and the data re-seeded.
4. **No secrets:** Never commit credentials. Provide a template file without real passwords.
5. **Portability:** All three members must be able to start the environment on their own computer.

---

### 4. Timeline

Count back from the presentation in week 8 after the autumn break to set real dates.

1. **Phase 1, environment check:** start 3 nodes, see all `UN` in `nodetool status`, and run one write and read.
2. **Phase 2, individual experiments:** write scripts, run experiments, save evidence.
3. **Phase 3, integration:** merge slides, finish the README, check that every experiment reproduces from a clean state.
4. **Phase 4, rehearsal:** the full 25 minutes, including handovers.

The detailed experiment steps are in the Experiment Guide at the end of this document (English only).

---

## Experiment Guide

This guide walks through every required Cassandra experiment from an empty computer to finished evidence. Follow the steps in order. After each step, compare your output with the expected result before moving on. All commands assume Docker Desktop (with the WSL 2 backend on Windows) or Docker Engine on Linux. Run shell scripts in WSL, Git Bash, or a Linux/macOS terminal.

---

### Guide 1: Environment setup (owner: Member A)

**Goal:** three Cassandra 5.0.9 nodes in one data centre, all showing `UN`, with a verified write and read.

#### Step 1.1: Check your computer
Three Cassandra nodes are three JVMs. Confirm at least 16 GB RAM (8 GB is very tight), at least 10 GB free disk, and that Docker is running.

```bash
docker --version 
docker compose version
docker info --format '{{.MemTotal}}'    # bytes available to Docker; aim for 8 GB (8589934592) or more
```

On Docker Desktop, raise the memory limit under **Settings > Resources** if the value is below 8 GB. On Windows with WSL 2, set `memory=8GB` in `%UserProfile%\.wslconfig` and run `wsl --shutdown`.

> ⚠️ **Megjegyzés a Windows környezethez:**  
> Az útmutatóban szereplő shell szkriptek és operátorok (`reset.sh`, `<<'EOF'`, `&&`, `| tee`, `(sed ...) &`) Linux/Bash környezetre íródtak. Windows operációs rendszeren ezeket WSL 2 (Ubuntu/Debian) vagy Git Bash terminálban javasolt futtatni, mert a natív Windows PowerShellben a bash operátorok (`<<`, `&`) szintaktikai hibát okoznak.


#### Step 1.2: Create the repository skeleton
```bash
mkdir -p cassandra-project/{slides,config,scripts,evidence} 
cd cassandra-project
git init
```

#### Step 1.3: Write `config/docker-compose.yml`
The file pins the image tag, caps memory, starts nodes in sequence through healthchecks, and publishes the CQL port only on `127.0.0.1` of node 1 (lab ports stay private). `restart: "no"` makes sure a node you stop later stays stopped.

```yaml
x-cassandra: &cassandra
  image: cassandra:5.0.9 
  networks: [cassnet] 
  mem_limit: 2560m 
  restart: "no" 
  environment:
    CASSANDRA_CLUSTER_NAME: nosql-lab 
    CASSANDRA_DC: dc1
    CASSANDRA_RACK: rack1
    CASSANDRA_ENDPOINT_SNITCH: GossipingPropertyFileSnitch 
    CASSANDRA_SEEDS: cass1
    MAX_HEAP_SIZE: 1G 
    HEAP_NEWSIZE: 256M
  healthcheck:
    test: ["CMD-SHELL", "cqlsh -e 'SELECT release_version FROM system.local' > /dev/null 2>&1"] 
    interval: 20s 
    timeout: 15s 
    retries: 30 
    start_period: 60s

services: 
  cass1:
    <<: *cassandra 
    container_name: cass1 
    hostname: cass1
    ports: ["127.0.0.1:9042:9042"]
    volumes: [cass1_data:/var/lib/cassandra] 

  cass2:
    <<: *cassandra 
    container_name: cass2 
    hostname: cass2 
    depends_on:
      cass1: {condition: service_healthy} 
    volumes: [cass2_data:/var/lib/cassandra]

  cass3:
    <<: *cassandra 
    container_name: cass3 
    hostname: cass3 
    depends_on:
      cass2: {condition: service_healthy}
    volumes: [cass3_data:/var/lib/cassandra]

networks: 
  cassnet: {}

volumes: 
  cass1_data: {} 
  cass2_data: {} 
  cass3_data: {}
```

> **Note:** If you have less than 16 GB RAM, lower `MAX_HEAP_SIZE` to `768M` and `HEAP_NEWSIZE` to `192M`. Both variables must always be set together.

#### Step 1.4: Start the cluster and wait
Starting takes roughly 3 to 6 minutes because each node waits for the previous one to be healthy.

```bash
docker compose -f config/docker-compose.yml up -d 
docker compose -f config/docker-compose.yml ps          # repeat until all three show (healthy)
docker logs --tail 20 cass1                            # look for "Starting listening for CQL clients"
```

**Expected:** `cass1`, `cass2` and `cass3` all show `healthy`. If a node shows `starting` for more than 5 minutes, see the troubleshooting table below.

#### Step 1.5: Verify the topology
```bash
docker exec cass1 nodetool status
```

**Expected output** (addresses and sizes will differ):
```text
Datacenter: dc1
===============
Status=Up/Down
|/ State=Normal/Leaving/Joining/Moving
--  Address     Load     Tokens  Owns  Host ID  Rack
UN  172.18.0.2  120 KiB  16      ?     ...      rack1
UN  172.18.0.3  110 KiB  16      ?     ...      rack1
UN  172.18.0.4  105 KiB  16      ?     ...      rack1
```

Write down the exact data-centre name shown after `Datacenter:`. The keyspace commands later use it. This guide assumes `dc1` because the compose file sets it; if yours differs, use your own name everywhere.

Next, confirm schema agreement. All three nodes must be listed under one schema version:
```bash
docker exec cass1 nodetool describecluster
```
**Expected:** under `Schema versions:` exactly one UUID followed by all three node addresses.

#### Step 1.6: Record versions and the image digest (needed for the README)
```bash
docker exec cass1 nodetool version
docker image inspect cassandra:5.0.9 --format '{{(index .RepoDigests 0)}}' 
docker exec cass1 cqlsh -e 'SHOW VERSION'
```

**Expected:** `ReleaseVersion: 5.0.9` and a digest of the form `cassandra@sha256:...`.  
Save all three lines to `evidence/00_environment/versions.txt`.

#### Step 1.7: Smoke test (write and read through different nodes)
```bash
docker exec -i cass1 cqlsh <<'EOF'
CREATE KEYSPACE smoke WITH replication = {'class': 'NetworkTopologyStrategy', 'dc1': 3};
CREATE TABLE smoke.t (id int PRIMARY KEY, v text); 
INSERT INTO smoke.t (id, v) VALUES (1, 'hello'); 
EOF

docker exec cass3 cqlsh -e "SELECT * FROM smoke.t;" 
docker exec cass1 cqlsh -e "DROP KEYSPACE smoke;"
```
**Expected:** the `SELECT` on `cass3` returns the row `1 | hello`. This proves a write through node 1 is visible through node 3.

#### Step 1.8: Check resources and logs under a small workload
```bash
docker stats --no-stream cass1 cass2 cass3    # memory use should stay below the 2560 MiB limit
docker system df                              # free disk used by images and volumes
docker logs --tail 50 cass2 | grep -iE "error|exception" || echo "no errors found"
```
Save the three outputs as `evidence/00_environment/resources.txt`.

#### Step 1.9: Create the reset script `scripts/reset.sh`
The script wipes all data, restarts the cluster, waits with a bounded loop (at most 20 minutes), and re-seeds the schema. It contains a command that deletes sample data, so label it clearly.

```bash
#!/usr/bin/env bash
# WARNING: 'down -v' DELETES all Cassandra data volumes. 
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
```

Make it executable with `chmod +x scripts/reset.sh`. You will create `scripts/00_schema.cql` in Guide 2. Run the script once to prove that a full reset works, then commit.

> ⚠️ **Fontos észrevétel / Sorrendi függőség (Futtatási hiba megelőzése):**  
> A `reset.sh` szkript 267. sora (`docker exec -i cass1 cqlsh < scripts/00_schema.cql`) megköveteli a sémafájlt, ám a Step 1.9 idején a `scripts/00_schema.cql` még **nem létezik** (azt csak a Guide 2-ben, a 2.1-es lépésben hozzuk létre).  
> Ha a szkriptet az útmutató szövege szerint már az 1.9-es lépésben lefuttatnád, az hibával leáll.  
> **Javaslat:** Az 1.9-es lépésben csak hozd létre a fájlt, de a tényleges első tesztfuttatást halaszd a Step 2.1 (és Step 2.2 seed generálás) utánra!


#### Step 1.10: Practise stopping and restoring a node
(This is the core of experiment B, so prove it works now).

```bash
docker stop cass3 
sleep 30
docker exec cass1 nodetool status             # cass3 should show DN
docker start cass3
# wait about 60-90 seconds
docker exec cass1 nodetool status             # all three UN again
```

#### Troubleshooting

| Symptom | Likely cause | Fix |
| :--- | :--- | :--- |
| A container exits immediately or shows `Exited (137)` | Out of memory | Raise Docker memory, or lower `MAX_HEAP_SIZE` and `HEAP_NEWSIZE` |
| Node 2 or 3 never becomes healthy | Previous node still bootstrapping, or low memory | Wait; read `docker logs cass2`; never start nodes in parallel |
| `nodetool status` shows `UJ` | Node is still joining | Wait until it becomes `UN` |
| Two or more schema versions in `describecluster` | Node recently joined, or gossip delay | Wait 30 to 60 seconds and repeat |
| Datacenter is `datacenter1`, not `dc1` | Variables not applied (stale volume) | Run `scripts/reset.sh`, or simply use the real name in your keyspaces |
| Port 9042 already in use | Another Cassandra or program running | Stop it or change the host port in the compose file |
| `cqlsh` says `Connection refused` | Container still starting, or you connected to a stopped node | Check `docker compose ps`, connect to a running node |

---

### Guide 2: Data model, data generator and CRUD (owners: Member B for the schema, Member C for the generator and CRUD)

**Goal:** a schema built around one query ("list all registrations for event X"), 120 generated rows, and a CRUD demonstration where every step shows the resulting state.

#### Step 2.1: Write the schema `scripts/00_schema.cql`
It creates both keyspaces and every table used in Guides 2 to 5, so one file rebuilds everything after a reset. Replace `dc1` if your data-centre name differs.

```sql
CREATE KEYSPACE IF NOT EXISTS nosql_rf3
WITH replication = {'class': 'NetworkTopologyStrategy', 'dc1': 3}; 

CREATE KEYSPACE IF NOT EXISTS nosql_rf1
WITH replication = {'class': 'NetworkTopologyStrategy', 'dc1': 1};

-- Main table: query = all registrations of one event 
CREATE TABLE IF NOT EXISTS nosql_rf3.registrations (
    event_id        text,           -- partition key
    seat_no         int,            -- clustering column
    attendee        text,
    email           text, 
    registered_at   timestamp,
    PRIMARY KEY ((event_id), seat_no)
) WITH CLUSTERING ORDER BY (seat_no ASC);

-- Guide 5 (lightweight transactions)
CREATE TABLE IF NOT EXISTS nosql_rf3.seat_claims ( 
    event_id        text,
    seat_no         int, 
    owner           text,
    PRIMARY KEY (event_id, seat_no)
);

-- Guide 4 (placement, RF 1): good design
CREATE TABLE IF NOT EXISTS nosql_rf1.registrations_good ( 
    event_id        text,
    seat_no         int, 
    attendee        text, 
    email           text,
    registered_at   timestamp,
    PRIMARY KEY ((event_id), seat_no)
);

-- Guide 4: deliberately poor design (constant partition key) 
CREATE TABLE IF NOT EXISTS nosql_rf1.registrations_bad (
    bucket          text, 
    event_id        text, 
    seat_no         int, 
    attendee        text,
    PRIMARY KEY ((bucket), event_id, seat_no)
);
```

Load it and check the result:
```bash
docker exec -i cass1 cqlsh < scripts/00_schema.cql
docker exec cass1 cqlsh -e "DESCRIBE KEYSPACE nosql_rf3;" | head -40
docker exec cass1 nodetool describecluster    # still one schema version?
```
**Expected:** no errors, `DESCRIBE` shows `replication = {'class': 'NetworkTopologyStrategy', 'dc1': '3'}`, and a single schema version.

#### Step 2.2: Write the data generator `scripts/generate_data.py`
It is deterministic (no randomness), so every team member produces identical data. It writes three seed files: one for the RF 3 table and two for the RF 1 comparison in Guide 4. Event sizes differ on purpose (E1 has 30 seats, E5 only 10).

```python
#!/usr/bin/env python3
"""Generate deterministic registration data for the Cassandra lab.""" 
import datetime
import pathlib

EVENTS = {"E1": 30, "E2": 20, "E3": 15, "E4": 25, "E5": 10, "E6": 20}  # seats per event
BASE = datetime.datetime(2026, 11, 1, 9, 0, 0) 
OUT = pathlib.Path("scripts")

def rows():
    for event, n in EVENTS.items(): 
        for seat in range(1, n + 1):
            ts = BASE + datetime.timedelta(minutes=seat) 
            yield {
                "event": event, 
                "seat": seat,
                "name": f"attendee_{event}_{seat:03d}", 
                "email": f"{event.lower()}.{seat}@example.org",
                "ts": ts.strftime("%Y-%m-%d %H:%M:%S"),
            }

def write(filename, header, template): 
    count = 0
    with open(OUT / filename, "w", encoding="utf-8") as f: 
        f.write(header + "\n")
        for r in rows(): 
            f.write(template.format(**r) + "\n") 
            count += 1
    print(f"{filename}: {count} rows")

write("seed_rf3.cql", "CONSISTENCY LOCAL_QUORUM;",
      "INSERT INTO nosql_rf3.registrations (event_id, seat_no, attendee, email, registered_at) "
      "VALUES ('{event}', {seat}, '{name}', '{email}', '{ts}');")

write("seed_rf1_good.cql", "CONSISTENCY ONE;",
      "INSERT INTO nosql_rf1.registrations_good (event_id, seat_no, attendee, email, registered_at) "
      "VALUES ('{event}', {seat}, '{name}', '{email}', '{ts}');")

write("seed_rf1_bad.cql", "CONSISTENCY ONE;",
      "INSERT INTO nosql_rf1.registrations_bad (bucket, event_id, seat_no, attendee) "
      "VALUES ('all', '{event}', {seat}, '{name}');")
```

Run it, then load the RF 3 data:
```bash
python3 scripts/generate_data.py
docker exec -i cass1 cqlsh < scripts/seed_rf3.cql
docker exec cass1 cqlsh -e "SELECT count(*) FROM nosql_rf3.registrations;"
```

**Expected:** the generator prints `120 rows` three times, and the count query returns `120`. Do not load the two `seed_rf1_*` files yet; that belongs to Guide 4. Add `python3 scripts/generate_data.py` and the seed load to the end of `reset.sh` once it works.

#### Step 2.3: Write the CRUD script `scripts/crud.cql`
The `SELECT '...' FROM system.local;` lines only print a label, so the saved output shows which step each result belongs to. Every change is followed by a read that verifies the state.

```sql
CONSISTENCY LOCAL_QUORUM;

SELECT '--- STEP 1 CREATE: insert one registration ---' AS step FROM system.local;
INSERT INTO nosql_rf3.registrations (event_id, seat_no, attendee, email, registered_at)
VALUES ('CRUD-DEMO', 1, 'Alice', 'alice@example.org', '2026-11-01 10:00:00');
SELECT * FROM nosql_rf3.registrations WHERE event_id = 'CRUD-DEMO' AND seat_no = 1;

SELECT '--- STEP 2 READ: all rows of one partition ---' AS step FROM system.local;
INSERT INTO nosql_rf3.registrations (event_id, seat_no, attendee, email, registered_at)
VALUES ('CRUD-DEMO', 2, 'Bob', 'bob@example.org', '2026-11-01 10:05:00');
SELECT * FROM nosql_rf3.registrations WHERE event_id = 'CRUD-DEMO'; 

SELECT '--- STEP 3 UPDATE: change the e-mail of seat 1 ---' AS step FROM system.local;
UPDATE nosql_rf3.registrations SET email = 'alice.new@example.org'
WHERE event_id = 'CRUD-DEMO' AND seat_no = 1;
SELECT * FROM nosql_rf3.registrations WHERE event_id = 'CRUD-DEMO' AND seat_no = 1;

SELECT '--- STEP 4 UPSERT: INSERT on an existing key overwrites it ---' AS step FROM system.local;
INSERT INTO nosql_rf3.registrations (event_id, seat_no, attendee) 
VALUES ('CRUD-DEMO', 1, 'Carol');
SELECT * FROM nosql_rf3.registrations WHERE event_id = 'CRUD-DEMO' AND seat_no = 1;

SELECT '--- STEP 5 UPSERT: UPDATE on a missing key creates the row ---' AS step FROM system.local;
UPDATE nosql_rf3.registrations SET attendee = 'Dave' 
WHERE event_id = 'CRUD-DEMO' AND seat_no = 3;
SELECT * FROM nosql_rf3.registrations WHERE event_id = 'CRUD-DEMO';

SELECT '--- STEP 6 DELETE: remove seat 2 ---' AS step FROM system.local; 
DELETE FROM nosql_rf3.registrations WHERE event_id = 'CRUD-DEMO' AND seat_no = 2;
SELECT * FROM nosql_rf3.registrations WHERE event_id = 'CRUD-DEMO';

SELECT '--- STEP 7 USEFUL QUERIES beyond a single-row lookup ---' AS step FROM system.local;
SELECT seat_no, attendee FROM nosql_rf3.registrations
WHERE event_id = 'E1' AND seat_no >= 5 AND seat_no <= 10; 
SELECT seat_no, attendee FROM nosql_rf3.registrations
WHERE event_id = 'E1' ORDER BY seat_no DESC LIMIT 5;
SELECT count(*) FROM nosql_rf3.registrations WHERE event_id = 'E1';

SELECT '--- CLEANUP ---' AS step FROM system.local;
DELETE FROM nosql_rf3.registrations WHERE event_id = 'CRUD-DEMO';
SELECT count(*) FROM nosql_rf3.registrations WHERE event_id = 'CRUD-DEMO';
```

#### Step 2.4: Run it and save the evidence
```bash
mkdir -p evidence/02_crud
docker exec -i cass1 cqlsh < scripts/crud.cql | tee evidence/02_crud/crud_output.txt
```

**Expected results, step by step:**
| Step | What you should see |
| :--- | :--- |
| **1 Create** | One row: seat 1, Alice, `alice@example.org` |
| **2 Read** | Two rows (seats 1 and 2), sorted by `seat_no` |
| **3 Update** | Seat 1 now has `alice.new@example.org`, name still Alice |
| **4 Upsert (INSERT)** | Seat 1 attendee is now Carol. No error, although the key existed |
| **5 Upsert (UPDATE)** | A new row for seat 3 (Dave) appears, although it did not exist |
| **6 Delete** | Seat 2 is gone; seats 1 and 3 remain |
| **7 Queries** | Seats 5 to 10 of E1 in ascending order; the last 5 seats of E1 in descending order; count 30 |
| **Cleanup** | Count 0 |

For the live demo, run the same statements in an interactive session (`docker exec -it cass1 cqlsh`) so the audience sees each command, and keep the script output as backup evidence.

#### Step 2.5: Show what Cassandra refuses (good for the questions)
Run this once and keep the error message:
```bash
docker exec cass1 cqlsh -e "SELECT * FROM nosql_rf3.registrations WHERE attendee = 'attendee_E1_001';"
```
**Expected:** an `InvalidRequest` error saying the query needs `ALLOW FILTERING`.  
Cassandra will not scan every partition unless forced to, because the table was designed for the query "by event", not "by attendee". A different query needs a different table.

> ℹ️ **Megjegyzés a projektkövetelményekhez (Kötelező vs. ajánlott elemek):**  
> Az `ALLOW FILTERING` hiba bemutatása szigorúan véve nem része a feladatkiírás (Section 4) kötelező CRUD minimumának, de kiemelten hasznos: közvetlenül alátámasztja a Cassandra *query-first* tervezési elvét és a Part 1 / Part 6-ban kért adatbázis-korlátok (limitations) magyarázatát.


#### Concepts Member C must be able to explain
| Term | Plain explanation | In this project |
| :--- | :--- | :--- |
| **Partition key** | The column whose hash decides which nodes store the row | `event_id` |
| **Clustering column** | Orders the rows inside one partition | `seat_no` |
| **Upsert** | `INSERT` and `UPDATE` do not check existence; they create or overwrite | Steps 4 and 5 |
| **Query-first design** | You decide the query first and design the table to serve it | "all registrations for event X" |

---

### Guide 3: Replication and availability, experiment B (owner: Member A)

**Goal:** show that with replication factor 3 and one node down, `LOCAL_QUORUM` (2 replicas) still works while `ALL` (3 replicas) fails, and that the cluster recovers when the node returns.

**Idea in one sentence:** the replication factor (RF) says how many copies exist (3); the consistency level (CL) says how many of those copies must answer a request (`LOCAL_QUORUM` = 2, `ALL` = 3).

#### Experiment record (fill in as you go)
| Field | What to record |
| :--- | :--- |
| **Configuration** | Cassandra 5.0.9, 3 nodes, data centre `dc1`, keyspace `nosql_rf3` (RF 3) |
| **Action** | Stop `cass3`; run reads and writes at `LOCAL_QUORUM` and `ALL` through `cass1` |
| **Expected result** | `LOCAL_QUORUM` read and write succeed; `ALL` read fails with an Unavailable error |
| **Observed result** | Paste the real output |
| **Interpretation** | Two of three replicas are alive, so 2 responses are possible but 3 are not |

#### Step 3.1: Start from a clean state
Run `scripts/reset.sh`, or at least confirm all three nodes are `UN`:
```bash
docker exec cass1 nodetool status
```
**Expected:** three lines starting with `UN`. Create the folder for evidence:
```bash
mkdir -p evidence/03_replication
```

#### Step 3.2: Seed a record at `ALL` while everything is healthy
This guarantees the record exists on all three replicas. Save the following as `scripts/b1_seed.cql`:

```sql
CONSISTENCY ALL;
SELECT '--- B1: seed at CL ALL, all nodes up ---' AS step FROM system.local; 
INSERT INTO nosql_rf3.registrations (event_id, seat_no, attendee)
VALUES ('B-TEST', 1, 'before_failure');
SELECT event_id, seat_no, attendee FROM nosql_rf3.registrations 
WHERE event_id = 'B-TEST' AND seat_no = 1;
```

Execute and record:
```bash
docker exec -i cass1 cqlsh < scripts/b1_seed.cql 2>&1 | tee evidence/03_replication/b1_seed.txt
docker exec cass1 nodetool getendpoints nosql_rf3 registrations B-TEST
```
**Expected:** the row shows `before_failure`, and `getendpoints` lists all three node addresses (RF 3 means every node holds a copy). Save the endpoint list too.

#### Step 3.3: Stop one node and wait for failure detection
Keep `cass1` running because every query goes through it. Stopping the node (not pausing the network) is the test.

```bash
docker stop cass3
for i in $(seq 1 12); do
    docker exec cass1 nodetool status | grep -q '^DN' && break 
    sleep 5
done
docker exec cass1 nodetool status | tee evidence/03_replication/b2_status_down.txt
```
**Expected:** one line starts with `DN` (down) and two with `UN`. If after 60 seconds no `DN` appears, repeat the check. Do not continue until `DN` is visible.

#### Step 3.4: Read, write and read at `LOCAL_QUORUM`, then try `ALL`
Save as `scripts/b2_failure.cql`. The `ALL` read is last on purpose, so the failure cannot hide earlier results.

```sql
CONSISTENCY LOCAL_QUORUM;
SELECT '--- B2a: LOCAL_QUORUM read, one node down ---' AS step FROM system.local;
SELECT event_id, seat_no, attendee FROM nosql_rf3.registrations 
WHERE event_id = 'B-TEST' AND seat_no = 1;

SELECT '--- B2b: LOCAL_QUORUM write, one node down ---' AS step FROM system.local;
INSERT INTO nosql_rf3.registrations (event_id, seat_no, attendee) 
VALUES ('B-TEST', 1, 'during_failure');

SELECT '--- B2c: LOCAL_QUORUM read back ---' AS step FROM system.local; 
SELECT event_id, seat_no, attendee FROM nosql_rf3.registrations
WHERE event_id = 'B-TEST' AND seat_no = 1;

CONSISTENCY ALL;
SELECT '--- B2d: ALL read, one node down (expected to FAIL) ---' AS step FROM system.local;
SELECT event_id, seat_no, attendee FROM nosql_rf3.registrations 
WHERE event_id = 'B-TEST' AND seat_no = 1;
```

Run:
```bash
docker exec -i cass1 cqlsh < scripts/b2_failure.cql 2>&1 | tee evidence/03_replication/b2_failure.txt
```

**Expected:**
| Part | Expected output |
| :--- | :--- |
| **B2a** | Row with `before_failure` |
| **B2b** | No error |
| **B2c** | Row with `during_failure` |
| **B2d** | Error like `Unavailable exception ... Cannot achieve consistency level ALL with required_replicas: 3 and alive_replicas: 2` |

> **Note:** A timeout instead of Unavailable is also possible if failure detection has not finished; wait and repeat. Use the failed `ALL` read as your evidence. Do not use a failed `ALL` write to claim that no replica changed, because a failed write may still have reached some replicas.

#### Step 3.5: Restore the node and check recovery
```bash
docker start cass3
for i in $(seq 1 24); do
    n=$(docker exec cass1 nodetool status | grep -c '^UN') 
    [ "$n" = "3" ] && break
    sleep 10 
done
docker exec cass1 nodetool status | tee evidence/03_replication/b3_status_restored.txt
```
**Expected:** all three nodes `UN` within about 4 minutes. If not, run `docker logs --tail 50 cass3` and look for errors.

Inspect hint delivery. Hints are small messages the live nodes stored for the missing node and replay after it returns:
```bash
docker exec cass1 nodetool statushandoff
docker exec cass1 nodetool tpstats | grep -i hint
docker logs --since 15m cass1 2>&1 | grep -i hint | tail -20
docker logs --since 15m cass3 2>&1 | grep -iE "hint|handoff" | tail -20
```
**Expected:** hinted handoff is `running`. Hint lines in the logs are likely but not guaranteed, because the outage was short. Save whatever you see.

Now read at `ALL`. Save as `scripts/b3_recovery.cql`:
```sql
CONSISTENCY ALL;
SELECT '--- B3: ALL read after recovery ---' AS step FROM system.local; 
SELECT event_id, seat_no, attendee FROM nosql_rf3.registrations
WHERE event_id = 'B-TEST' AND seat_no = 1;
```

Run:
```bash
docker exec -i cass1 cqlsh < scripts/b3_recovery.cql 2>&1 | tee evidence/03_replication/b3_recovery.txt
```
**Expected:** the row shows `during_failure`, which is the value written while `cass3` was down. This proves all three replicas now agree on the new value for a read at `ALL`. Be careful with the wording: an `ALL` read can trigger read repair, so it shows the data is consistent now, not that it was synchronised before you read.

#### Step 3.6 (only if recovery stalls): run a repair
```bash
docker exec cass3 nodetool repair nosql_rf3
```
Then repeat the `ALL` read. Repair is the documented fix when hints are not enough, for example after a long outage.

#### Step 3.7: Reset before the next experiment
Delete the test row so later runs start clean:
```bash
docker exec cass1 cqlsh -e "DELETE FROM nosql_rf3.registrations WHERE event_id = 'B-TEST';"
```

#### What to say in the presentation (about 4 minutes)
1. **One slide:** RF 3 versus CL. Three copies exist; `LOCAL_QUORUM` needs 2, `ALL` needs 3.
2. **Live or recorded:** `nodetool status` with 3 `UN`, seed at `ALL`, then stop `cass3` and show `DN`.
3. Show the successful `LOCAL_QUORUM` read, write and read-back, then the failed `ALL` read with the Unavailable message.
4. Restart `cass3`, show 3 `UN` and the `ALL` read returning `during_failure`.
5. **Limitation to state:** this test stops a process on one computer. It does not prove the cluster survives losing the whole computer.

#### Common mistakes
| Mistake | Why it matters |
| :--- | :--- |
| Setting `CONSISTENCY` in one `cqlsh -e` call and the query in another | Each call is a new session, so the setting is lost. Use a file or an interactive session |
| Connecting to the node you stopped | The client must stay connected to a live node (`cass1`) |
| Testing immediately after `docker stop` | Failure detection needs several seconds; wait for `DN` |
| Treating a timeout as proof of an outcome | A timeout means the result is unknown |

---

### Guide 4: Partition-key design and placement, experiment C (owner: Member B)

**Goal:** compare a good partition key (`event_id`) with a deliberately poor one (a constant), count rows per partition, and show which node stores each partition.

**Why RF 1 here:** with 3 nodes and RF 3, every node holds a copy of every partition, so placement is invisible. With RF 1 each partition lives on exactly one node. RF 1 has no backup copy, so keep all three nodes running during this experiment and never stop one.

#### Experiment record
| Field | What to record |
| :--- | :--- |
| **Configuration** | 3 nodes, keyspace `nosql_rf1` (RF 1), tables `registrations_good` and `registrations_bad` |
| **Action** | Load 120 rows into each table; count rows per partition; run `nodetool getendpoints` for several keys |
| **Expected result** | Good design: 6 partitions of 10 to 30 rows spread over several nodes. Poor design: 1 partition of 120 rows on one node |
| **Observed result** | Paste the real outputs and the key-to-node table |
| **Interpretation** | The partition key decides placement and how work is spread |

#### Step 4.1: Start from a clean state with all nodes up
```bash
docker exec cass1 nodetool status          # three lines starting with UN
mkdir -p evidence/04_partitioning
```
If you have not generated the data yet, run `python3 scripts/generate_data.py` first.

#### Step 4.2: Load both RF 1 tables
```bash
docker exec -i cass1 cqlsh < scripts/seed_rf1_good.cql 
docker exec -i cass1 cqlsh < scripts/seed_rf1_bad.cql 
docker exec cass1 cqlsh -e "SELECT count(*) FROM nosql_rf1.registrations_good;"
docker exec cass1 cqlsh -e "SELECT count(*) FROM nosql_rf1.registrations_bad;"
```
**Expected:** `120` for both. Loading a file a second time still gives 120, because an insert on an existing key is an upsert, not a new row. Never count repeated upserts as extra rows.

#### Step 4.3: Run the intended query on both designs
The intended query is "list all registrations for event E1".
```bash
docker exec cass1 cqlsh -e "SELECT event_id, seat_no, attendee FROM nosql_rf1.registrations_good WHERE event_id = 'E1' LIMIT 5;"
docker exec cass1 cqlsh -e "SELECT event_id, seat_no, attendee FROM nosql_rf1.registrations_bad WHERE bucket = 'all' AND event_id = 'E1' LIMIT 5;"
```
**Expected:** both return the same E1 rows. The difference is not the answer but where the data lives: in the poor design the query must first go to the single partition `all` that holds every event.

#### Step 4.4: Count distinct primary keys per partition
```bash
docker exec cass1 cqlsh -e "SELECT event_id, count(*) FROM nosql_rf1.registrations_good GROUP BY event_id;" | tee evidence/04_partitioning/partition_sizes_good.txt
docker exec cass1 cqlsh -e "SELECT bucket, count(*) FROM nosql_rf1.registrations_bad GROUP BY bucket;" | tee evidence/04_partitioning/partition_sizes_bad.txt
```

**Expected:**
| Design | Partitions | Rows per partition |
| :--- | :--- | :--- |
| `registrations_good` | 6 (E1 to E6) | E1 30, E2 20, E3 15, E4 25, E5 10, E6 20 |
| `registrations_bad` | 1 (`all`) | 120 |

Cross-check the numbers independently from the seed file (distinct keys, not repeated inserts):
```bash
python3 - <<'EOF' 
import re, collections
text = open('scripts/seed_rf1_good.cql').read()
rows = set(re.findall(r"VALUES \('(\w+)', (\d+),", text)) 
count = collections.Counter(event for event, seat in rows) 
print(dict(count), 'total', sum(count.values()))
EOF
```

> 💡 **Megjegyzés (Futtatási tanács PowerShell esetén):**  
> A `python3 - <<'EOF'` Bash heredoc beviteli forma Windows PowerShellben szintaktikai hibát ad. PowerShell használata esetén ajánlott ezt a pár sort külön Python fájlba tenni (pl. `scripts/verify_rf1_counts.py`), vagy WSL 2 / Git Bash alól futtatni.


Then look at the storage statistics. Flush first, because data starts in memory:
```bash
for n in cass1 cass2 cass3; do docker exec $n nodetool flush nosql_rf1; done 

for n in cass1 cass2 cass3; do
    echo "== $n =="
    docker exec $n nodetool tablestats nosql_rf1.registrations_good | grep -E "Number of partitions|Space used \(live\)"
    docker exec $n nodetool tablestats nosql_rf1.registrations_bad | grep -E "Number of partitions|Space used \(live\)"
done | tee evidence/04_partitioning/tablestats.txt
```
**Expected:** the good table's partitions are spread over several nodes (each node reports some partitions and some space), while the bad table reports its single partition on one node only and zero on the others. The numbers are estimates, so use them to show the pattern, not exact values.

#### Step 4.5: Find the replica node for each partition key
Map container IPs to names first:
```bash
docker inspect -f '{{.Name}} {{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' cass1 cass2 cass3 | tee evidence/04_partitioning/node_ips.txt
```

Then ask Cassandra where each key lives. With a single text partition key, pass the real value:
```bash
for k in E1 E2 E3 E4 E5 E6; do
    echo "registrations_good key=$k -> $(docker exec cass1 nodetool getendpoints nosql_rf1 registrations_good $k)"
done | tee evidence/04_partitioning/endpoints_good.txt

echo "registrations_bad key=all -> $(docker exec cass1 nodetool getendpoints nosql_rf1 registrations_bad all)" | tee evidence/04_partitioning/endpoints_bad.txt
```
**Expected:** each key prints exactly one IP address (RF 1). The six good keys should appear on at least two different nodes; `all` prints a single node and holds all 120 rows.

If all six keys happen to land on the same node (unlikely), test more keys. The command only computes the token, so the key does not need to exist as data:
```bash
for k in E7 E8 E9 E10 E11 E12; do
    echo "$k -> $(docker exec cass1 nodetool getendpoints nosql_rf1 registrations_good $k)"
done
```

Show the token behind the placement, which is what actually decides the node:
```bash
docker exec cass1 cqlsh -e "SELECT DISTINCT event_id, token(event_id) FROM nosql_rf1.registrations_good;" | tee evidence/04_partitioning/tokens.txt 
docker exec cass1 nodetool status nosql_rf1
```
The last command shows an effective ownership percentage per node for this RF 1 keyspace; the three values add up to about 100%.

Build the table you will present (fill in from your outputs; the values below are placeholders):
| Partition key | Token | Replica IP | Node |
| :--- | :--- | :--- | :--- |
| **E1** | *(from tokens.txt)* | *(from endpoints_good.txt)* | *(map with node_ips.txt)* |
| **E2** | | | |
| **E3** | | | |
| **all (bad table)** | | | |

> **Note:** `getendpoints` shows the node that *stores* the data. It does not show which node happened to coordinate a query.

#### Step 4.6 (optional): see the coordinator and replica with tracing
```bash
docker exec -it cass1 cqlsh
```
Inside cqlsh:
```sql
CONSISTENCY ONE; 
TRACING ON;
SELECT * FROM nosql_rf1.registrations_good WHERE event_id = 'E1' LIMIT 3;
TRACING OFF;
exit
```
The trace lists the replica that served the read. Type `TRACING OFF;` and `exit` afterwards.

> ℹ️ **Megjegyzés a projektkövetelményekhez (Opcionális demonstráció):**  
> A tantárgyi kiírás (5.4.C fejezet, 410. sor) szerint a kötelező bizonyítékok a tábladefiníciók, a célzott lekérdezés, a partícióméretek összehasonlítása és a `nodetool getendpoints` kulcs-csomópont hozzárendelése. A `TRACING` alkalmazása opcionális, de látványosan alátámasztja, hogy melyik replika szolgálta ki az olvasást.


#### Step 4.7: Explain the result
- The partition key is hashed into a token, and the token decides the node. Clustering columns only sort rows inside a partition.
- **Good design:** six small partitions spread over several nodes. Requests for different events go to different nodes.
- **Poor design:** one partition of 120 rows on one node. In a real system that partition grows without limit and that node serves every request, which is a hotspot.
- More distinct keys do not guarantee perfectly even load. One very popular event is still one partition on one node, so the good design reduces hotspot risk but does not remove it.

#### Step 4.8: Clean up
Keep the RF 1 data if you want to repeat the screenshots; otherwise run `scripts/reset.sh`.

#### Common mistakes
| Mistake | Why it matters |
| :--- | :--- |
| Stopping a node while using the RF 1 keyspace | Data on that node becomes unavailable because there is no copy |
| Counting rows after loading the same file twice and adding the numbers | Repeated upserts are not new rows; count distinct primary keys |
| Passing `'E1'` with quotes to `getendpoints` in some shells | Pass the plain value `E1`; keep quotes out of the shell argument |
| Reading `getendpoints` as the coordinator | It lists the replica owners only |

---

### Guide 5: Lightweight transactions, experiment D (owner: Member B)

**Goal:** two independent clients try to claim the same seat. With `IF NOT EXISTS` the first succeeds (`[applied] = True`) and the second is refused (`[applied] = False`) and sees the real owner. A plain `INSERT` shows the contrast: the second write silently overwrites the first.

**Scope:** a lightweight transaction (LWT) is a conditional change to **one row**. It is not a multi-row SQL transaction and it is not a `BATCH`. It needs extra coordination (a Paxos-based protocol with several round trips), so it is slower than a normal write.

#### Experiment record
| Field | What to record |
| :--- | :--- |
| **Configuration** | 3 nodes all `UN`, table `nosql_rf3.seat_claims`, `CONSISTENCY LOCAL_QUORUM`, `SERIAL CONSISTENCY LOCAL_SERIAL` |
| **Action** | Client A then client B run `INSERT ... IF NOT EXISTS` for the same event and seat |
| **Expected result** | A: `[applied] = True`. B: `[applied] = False` and the existing owner is returned |
| **Observed result** | Paste both results and the final read |
| **Interpretation** | The condition is checked and applied atomically for that row, so the first claim is never overwritten |

#### Step 5.1: Restore the full cluster
All three nodes must be up. If you just finished experiment B, make sure `cass3` is back:
```bash
docker exec cass1 nodetool status          # three lines starting with UN
mkdir -p evidence/05_lwt
```

#### Step 5.2: Prepare two independent client sessions
Open two terminals. In terminal 1 connect to `cass1`, in terminal 2 connect to `cass2`, so the two clients even use different coordinators.

```bash
# terminal 1 (client A) 
docker exec -it cass1 cqlsh

# terminal 2 (client B) 
docker exec -it cass2 cqlsh
```

In each terminal set both consistency levels. These are `cqlsh` commands, not CQL statements, and they only apply in that session:
```sql
CONSISTENCY LOCAL_QUORUM;
SERIAL CONSISTENCY LOCAL_SERIAL; 
CONSISTENCY;
SERIAL CONSISTENCY;
```
**Expected:** the last two commands print `Current consistency level is LOCAL_QUORUM.` and `Current serial consistency level is LOCAL_SERIAL.`. Take a screenshot of both terminals showing this; the assignment asks for the settings as evidence.

#### Step 5.3: Pick a fresh event id
The seat must be unclaimed, so use an id nobody has used. For the live demo use `demo-run-001`; for every repetition use `demo-run-002`, `demo-run-003`, and so on. Never reuse an id and never write ordinary updates to a test row.

#### Step 5.4: Client A claims the seat (terminal 1)
```sql
INSERT INTO nosql_rf3.seat_claims (event_id, seat_no, owner) 
VALUES ('demo-run-001', 1, 'Alice') IF NOT EXISTS;
```
**Expected output:**
```text
[applied]
---------
     True
```

#### Step 5.5: Client B tries the same seat (terminal 2)
```sql
INSERT INTO nosql_rf3.seat_claims (event_id, seat_no, owner) 
VALUES ('demo-run-001', 1, 'Bob') IF NOT EXISTS;
```
**Expected output:**
```text
[applied] | event_id     | seat_no | owner
----------+--------------+---------+-------
    False | demo-run-001 |       1 | Alice
```
Cassandra refuses the second claim and returns the current row, which shows who owns the seat.

#### Step 5.6: Verify the final state (either terminal)
```sql
SELECT * FROM nosql_rf3.seat_claims WHERE event_id = 'demo-run-001' AND seat_no = 1;
```
**Expected:** one row with `owner = Alice`. Bob's attempt changed nothing.

#### Step 5.7: Contrast with an ordinary upsert (use a different event id)
Do not mix this with the LWT test row above.

```sql
-- terminal 1
INSERT INTO nosql_rf3.seat_claims (event_id, seat_no, owner) VALUES ('demo-plain-001', 1, 'Alice');

-- terminal 2
INSERT INTO nosql_rf3.seat_claims (event_id, seat_no, owner) VALUES ('demo-plain-001', 1, 'Bob');

-- either terminal
SELECT * FROM nosql_rf3.seat_claims WHERE event_id = 'demo-plain-001' AND seat_no = 1;
```
**Expected:** no error for either insert, and the final owner is `Bob`. Alice's claim was silently overwritten. This is exactly the problem `IF NOT EXISTS` prevents.

#### Step 5.8: Save repeatable, non-interactive evidence
Interactive sessions are best for the live demo; scripts give clean logs. Create three template files that contain the placeholder `__EVENT__`:

**`scripts/d_client_a.cql`**:
```sql
CONSISTENCY LOCAL_QUORUM;
SERIAL CONSISTENCY LOCAL_SERIAL;
SELECT '--- D client A: claim seat 1 ---' AS step FROM system.local; 
INSERT INTO nosql_rf3.seat_claims (event_id, seat_no, owner)
VALUES ('__EVENT__', 1, 'Alice') IF NOT EXISTS;
```

**`scripts/d_client_b.cql`**:
```sql
CONSISTENCY LOCAL_QUORUM;
SERIAL CONSISTENCY LOCAL_SERIAL;
SELECT '--- D client B: claim the same seat ---' AS step FROM system.local; 
INSERT INTO nosql_rf3.seat_claims (event_id, seat_no, owner)
VALUES ('__EVENT__', 1, 'Bob') IF NOT EXISTS;
```

**`scripts/d_final_read.cql`**:
```sql
CONSISTENCY LOCAL_QUORUM;
SELECT '--- D final state ---' AS step FROM system.local;
SELECT * FROM nosql_rf3.seat_claims WHERE event_id = '__EVENT__' AND seat_no = 1;
```

Run them in a controlled order with a fresh event id:
```bash
EV="demo-run-$(date +%s)"
sed "s/__EVENT__/$EV/g" scripts/d_client_a.cql | docker exec -i cass1 cqlsh 2>&1 | tee evidence/05_lwt/d_client_a.txt
sed "s/__EVENT__/$EV/g" scripts/d_client_b.cql | docker exec -i cass2 cqlsh 2>&1 | tee evidence/05_lwt/d_client_b.txt
sed "s/__EVENT__/$EV/g" scripts/d_final_read.cql | docker exec -i cass3 cqlsh 2>&1 | tee evidence/05_lwt/d_final_read.txt
```
**Expected:** client A prints `True`, client B prints `False` with owner `Alice`, and the final read (through a third node) shows `Alice`.

> 💡 **Megjegyzés (Futtatási környezet):**  
> A `sed` és a `date +%s` parancsok Linux/Unix eszközök. Windows rendszeren ezek a szkriptek WSL 2 vagy Git Bash alól futtathatók közvetlenül. PowerShell használata esetén a `demo-run-$(Get-Date -UFormat %s)` és `(Get-Content ...).Replace(...)` konstrukciókkal helyettesíthetők.

#### Step 5.9 (optional): simultaneous attempts
Start both at the same moment:
```bash
EV="demo-race-$(date +%s)"
(sed "s/__EVENT__/$EV/g" scripts/d_client_a.cql | docker exec -i cass1 cqlsh > evidence/05_lwt/race_a.txt 2>&1) &
(sed "s/__EVENT__/$EV/g" scripts/d_client_b.cql | docker exec -i cass2 cqlsh > evidence/05_lwt/race_b.txt 2>&1) & 
wait
cat evidence/05_lwt/race_a.txt evidence/05_lwt/race_b.txt
```
**Expected:** exactly one `True` and one `False`. Which client wins can differ between runs, and that is correct behaviour.

> ℹ️ **Megjegyzés a projektkövetelményekhez (Opcionális kiterjesztés):**  
> A tantárgyi kiírás (5.4.D fejezet, 470. sor) kimondja: *"Először ellenőrzött sorrendben futtassátok a kísérleteket; az egyidejű kísérletek opcionális kiterjesztést jelentenek."* A prezentációban és a leadandó anyagban a Step 5.4–5.6 közötti szekvenciális demonstráció a kötelező (ahol egyértelmű az első és a második foglaló kimenetele); a párhuzamos versenyhelyzet (`demo-race`) hasznos plusz, de nem feltétele a teljes pontszámnak.


#### Step 5.10: Handling timeouts
If a conditional write returns a `WriteTimeout` (the message mentions `CAS` or a serial phase), the outcome is **unknown**: the claim may or may not have been applied. This is not the same as `[applied] = False`. Read the row at `SERIAL` consistency before deciding what to do:
```sql
SERIAL CONSISTENCY LOCAL_SERIAL; 
CONSISTENCY LOCAL_SERIAL;
SELECT * FROM nosql_rf3.seat_claims WHERE event_id = 'demo-run-001' AND seat_no = 1;
```

**Why two consistency settings:** the serial consistency level (`LOCAL_SERIAL`) controls the Paxos agreement phase that decides whether the condition holds. The normal consistency level (`LOCAL_QUORUM`) controls the final commit and ordinary reads. They serve different phases of one conditional operation.

#### Comparison for the slides
| Feature | Ordinary `INSERT` | `INSERT ... IF NOT EXISTS` |
| :--- | :--- | :--- |
| **Checks existence first** | No (upsert) | Yes |
| **Second writer** | Overwrites silently | Refused, `[applied] = False` |
| **Cost** | One round of replica writes | Several round trips (Paxos), slower |
| **Scope** | Any rows | Conditions on one row (one partition) |

#### What LWT is not
- **Not a general SQL transaction:** there is no multi-row `BEGIN ... COMMIT` with rollback in this task.
- **Not a `BATCH`:** a logged batch ensures its writes are eventually all applied, but it gives no cross-partition isolation. Keep batches out of this demonstration.

#### What to say in the presentation (about 4 minutes)
1. **Problem:** two customers want seat 1. Plain writes let the later one overwrite the earlier one (show Step 5.7 result as a screenshot).
2. Show both terminals with the two consistency settings.
3. **Live:** client A returns `True`, client B returns `False` and the owner `Alice`; final read shows `Alice`.
4. Explain the cost (extra coordination) and the scope (single row), and mention that a timeout means unknown, not false.

#### Common mistakes
| Mistake | Why it matters |
| :--- | :--- |
| Reusing an event id | The seat is already claimed, so client A gets `False` too |
| Running `CONSISTENCY ...` in a different session than the insert | Each `cqlsh` session has its own settings |
| Mixing ordinary writes and `IF NOT EXISTS` on the same row | The assignment says not to; it makes the outcome hard to interpret |
| Running the test while a node is still down | LWT needs enough live replicas; restore all three first |

---

### Guide 6: Evidence, README, final check and rehearsal (everyone)

**Goal:** a repository that a stranger can start from zero, plus a rehearsed 25-minute presentation.

#### Step 6.1: Final repository layout
```text
cassandra-project/ 
├── README.md
├── .env.example              # credential template, no real secrets 
├── config/
│   └── docker-compose.yml
├── scripts/
│   ├── reset.sh
│   ├── 00_schema.cql
│   ├── generate_data.py 
│   ├── seed_rf3.cql
│   ├── seed_rf1_good.cql
│   ├── seed_rf1_bad.cql 
│   ├── crud.cql
│   ├── b1_seed.cql
│   ├── b2_failure.cql
│   ├── b3_recovery.cql 
│   ├── d_client_a.cql
│   ├── d_client_b.cql
│   └── d_final_read.cql
├── evidence/
│   ├── 00_environment/
│   ├── 02_crud/
│   ├── 03_replication/
│   ├── 04_partitioning/
│   └── 05_lwt/
└── slides/
```

This cluster runs without authentication, and the CQL port is published only on `127.0.0.1`, so no real password exists. Still add a `.env.example` with placeholders (for example `CASSANDRA_USER=changeme`) so the handout's credential-template requirement is met, and never commit real values.

#### Step 6.2: README checklist (Member A writes, everyone reviews)
- [ ] Operating system and Docker version used
- [ ] Database version and edition: Apache Cassandra 5.0.9, image tag and digest from `evidence/00_environment/versions.txt`
- [ ] Licence: Apache License 2.0, no paid licence or cloud subscription needed
- [ ] Prerequisites: RAM, free disk, Docker, Python 3
- [ ] Topology: three nodes `cass1`, `cass2`, `cass3`, one data centre `dc1`, one rack, seed `cass1`, private Docker network `cassnet`
- [ ] How to start, connect (`docker exec -it cass1 cqlsh`), stop, and reset; mark the command that deletes data (`docker compose down -v` inside `reset.sh`)
- [ ] Resource settings: heap `1G`, new size `256M`, container limit `2560m`
- [ ] Where each experiment's script and evidence live, and the expected result of each
- [ ] Data source: self-generated by `generate_data.py` (deterministic, no external data)
- [ ] Contribution table (Step 6.5)

#### Step 6.3: Evidence map
| Experiment | Files that must exist | Shows |
| :--- | :--- | :--- |
| **Environment** | `versions.txt`, `resources.txt`, `nodetool status` output | Version, 3 nodes `UN`, memory and disk use |
| **CRUD** | `crud_output.txt`, the `ALLOW FILTERING` error | Create, read, update, delete, upsert, range query |
| **B Replication** | `b1_seed.txt`, `b2_status_down.txt`, `b2_failure.txt`, `b3_status_restored.txt`, `b3_recovery.txt` | `LOCAL_QUORUM` works, `ALL` fails, recovery |
| **C Partitioning** | `partition_sizes_*.txt`, `tablestats.txt`, `endpoints_*.txt`, `tokens.txt`, `node_ips.txt` | Partition sizes and key-to-node placement |
| **D LWT** | `d_client_a.txt`, `d_client_b.txt`, `d_final_read.txt`, screenshot of both consistency settings | `True`, `False`, final owner |

For each experiment add a short `notes.md` using the template: configuration, action, expected result, observed result, interpretation.

#### Step 6.4: Clean-state test (do this twice before the presentation)
Pretend you are a stranger:
1. Run `scripts/reset.sh` from a fresh clone of the repository.
2. Confirm `nodetool status` shows three `UN` and the schema is loaded.
3. Run Guide 2, Guide 3, Guide 4 and Guide 5 in that order using only the README and the scripts.
4. Compare each result with the expected result in the evidence notes.
5. Fix every command that fails or differs, then repeat once on a second team member's computer.

#### Step 6.5: Contribution record (honest, per member)
| Member | What they did | Evidence (commits, files) |
| :--- | :--- | :--- |
| **A** | *(fill in)* | *(fill in)* |
| **B** | *(fill in)* | *(fill in)* |
| **C** | *(fill in)* | *(fill in)* |

#### Step 6.6: Presentation run sheet (25 minutes)
Decide live versus recorded in advance and keep a backup recording of every live part.

| Minutes | Part | Speaker | Format |
| :--- | :--- | :--- | :--- |
| **0:00 to 3:00** | 1 Introduction | **C** | Slides, with one cited source for the history |
| **3:00 to 6:00** | 2 Installation and setup | **A** | `docker compose ps`, `nodetool status`, versions on screen |
| **6:00 to 8:00** | 3 Database structure | **B** | Table definition slide, partition key and clustering column |
| **8:00 to 13:00** | 4 Basic operations | **C** | Live CRUD plus one range query |
| **13:00 to 17:00** | 5B Replication | **A** | Recorded or screenshots (stop node, `LOCAL_QUORUM` versus `ALL`) |
| **17:00 to 20:00** | 5C Partitioning | **B** | Screenshots and the key-to-node table |
| **20:00 to 24:00** | 5D Lightweight transactions | **B** | Live two-terminal `IF NOT EXISTS` demo |
| **24:00 to 25:00** | 6 Conclusion | **A** | Slide: use case, one strength, one limitation |

> The handout allows logs, screenshots or a short recording for the longer experiments, as long as they are labelled as such. The live parts are CRUD and LWT.

#### Step 6.7: Conclusion content (Member A)
- **Use case:** event registration or sensor data with high write volume and queries known in advance.
- **Strength tied to your result:** with RF 3, the cluster kept reading and writing at `LOCAL_QUORUM` with one node down.
- **Limitation tied to your result:** tables must be designed around queries (the `ALLOW FILTERING` error), and conditional writes cost extra coordination.
- **Notice:** Do not claim Cassandra is better in general, and do not claim production scalability from a one-computer test.

#### Step 6.8: Likely questions and short answers
| Question | Short answer |
| :--- | :--- |
| **What is the difference between RF and CL?** | RF is how many copies exist; CL is how many must respond to one request |
| **Why did `ALL` fail but `LOCAL_QUORUM` work?** | Two of three replicas were alive: enough for 2, not for 3 |
| **What does the partition key do?** | Its hash (token) decides which node stores the row; clustering columns only sort rows inside the partition |
| **Why RF 1 for the placement test?** | With RF 3 on three nodes every node has every partition, so placement is invisible |
| **What is a hotspot?** | A partition or node that receives far more work than others; one popular event can still cause it |
| **Is an LWT a SQL transaction?** | No. It is a conditional change on one row, using extra coordination |
| **Does your test prove production fault tolerance?** | No. It stops one process on one computer; it does not show survival of losing the computer |

#### Step 6.9: Final 30-minute checklist before presenting
- [ ] All three containers healthy and `nodetool status` shows three `UN`
- [ ] Data re-seeded (`SELECT count(*) FROM nosql_rf3.registrations;` returns 120)
- [ ] Two terminals open for the LWT demo with consistency levels already set
- [ ] Backup recordings and screenshots open and ready
- [ ] No dependency on a live external service or internet connection
- [ ] Every member can explain their own part and the basics of the other parts
- [ ] Slides end with a sources list

---

*If you need help with any step, tell me the step number and the exact error message, and I will help you debug it.*
