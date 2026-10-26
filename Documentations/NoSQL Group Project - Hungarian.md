NoSQL group <u>project</u> 
NoSQL csoportos <u>projekt</u>

Big Data Management and Processing 
Big Data Kezelés és Feldolgozás

##### **GROUP PROJECT ASSIGNMENT** 
##### **CSOPORTOS PROJEKTFELADAT**

# **NoSQL databases** 
# **NoSQL adatbázisok**

Big Data Management and Processing 
Big Data Kezelés és Feldolgozás

#### **Presentation: Week 8, after the autumn break.** 
#### **Prezentáció: 8. hét, az őszi szünet után.**

Use **one database** , as confirmed in your team’s registration. This handout covers **Redis, Apache CouchDB, Neo4j, and Apache Cassandra** . Build a reproducible demonstration of its data model, basic operations, and distributed or transactional behaviour. 

Használjatok **egy adatbázist**, a csapatotok regisztrációjában megerősítettek szerint. Ez a segédlet a **Redis, Apache CouchDB, Neo4j és Apache Cassandra** rendszerekkel foglalkozik. Készítsetek egy reprodukálható demonstrációt annak adatmodelljéről, alapvető műveleteiről, valamint elosztott vagy tranzakciós működéséről.

#### **Scope** 
#### **Hatókör és feladat**

Read the common instructions and complete Sections 1–6 for **your database only** . Use one main example, such as event registrations, reservations, a catalogue, or sensor readings. Isolated test records may be used for error scenarios. A command-line client, database browser, notebook, or short script is sufficient. **A complete web application is not required.** 

Olvassátok el a közös utasításokat, és végezzétek el az 1–6. fejezeteket **kizárólag a saját adatbázisotokra**. Használjatok egy fő példát, mint például eseményregisztrációk, foglalások, katalógus vagy szenzoros mérések. Elszigetelt tesztrekordok használhatók a hibaszcenáriók bemutatásához. Egy parancssori kliens, adatbázis-böngésző, notebook vagy egy rövid script elegendő. **Egy teljes webes alkalmazás elkészítése nem szükséges.**

Share the work evenly and record each member’s contribution. The group presentation is compulsory. Prepare the environment and sample data in advance. Part 2 explains the working setup, rather than installing it live. 

Osszátok meg a munkát egyenlően, és rögzítsétek az egyes tagok hozzájárulását. A csoportos prezentáció kötelező. Készítsétek elő előre a környezetet és a mintaadatokat. A 2. rész a működő környezetet mutatja be, nem pedig élőben telepíti azt.

#### **Presentation plan** 
#### **Prezentációs terv**

|**Part**|**Content**|**Time**|
|---|---|---|
|1|Introduction to the database|3 minutes|
|2|Installation and setup|3 minutes|
|3|Database structure and data model|2 minutes|
|4|Basic queries and operations|5 minutes|
|5|Replication, partitioning/scalability, and transactions|11 minutes|
|6|Conclusion|1 minute|
||**Presentation, including demonstrations**|**25 minutes**|

|**Rész**|**Tartalom**|**Időtartam**|
|---|---|---|
|1|Az adatbázis bemutatása|3 perc|
|2|Telepítés és beállítás|3 perc|
|3|Adatbázis-struktúra és adatmodell|2 perc|
|4|Alapvető lekérdezések és műveletek|5 perc|
|5|Replikáció, particionálás/skálázhatóság és tranzakciók|11 perc|
|6|Összegzés|1 perc|
||**Prezentáció, a demonstrációkat is beleértve**|**25 perc**|

Allow approximately **3 additional minutes for questions** , giving about **28 minutes per team** , excluding changeover. The section timings are a guide within the 25-minute presentation. For Part 5, use roughly 4 minutes for replication, 3 for partitioning/scalability, and 4 for transactions. 

Hagyjatok körülbelül **3 további percet a kérdésekre**, így nagyjából **28 perc jut egy csapatra**, a váltás idejét nem számítva. A fejezetek időtartamai támpontul szolgálnak a 25 perces prezentáción belül. Az 5. részhez használjatok megközelítőleg 4 percet a replikációra, 3 percet a particionálásra/skálázhatóságra és 4 percet a tranzakciókra.

#### **Where to find your database track** 
#### **Hol található a választott adatbázis iránya (track)**

|**Track**|**Main practical focus**|**Page**|
|---|---|---|
|Redis|Sentinel failover, hash slots, command transactions|5|
|CouchDB|Replication conflicts, partitioned queries, document updates|8|
|Neo4j|Graph queries, indexing, commit and rollback|11|
|Cassandra|Replica availability, partition keys, conditional writes|13|

|**Irány (Track)**|**Fő gyakorlati fókusz**|**Oldal**|
|---|---|---|
|Redis|Sentinel feladatátvétel, hash slotok, parancstranzakciók|5|
|CouchDB|Replikációs konfliktusok, particionált lekérdezések, dokumentumfrissítések|8|
|Neo4j|Gráflekérdezések, indexelés, commit és rollback|11|
|Cassandra|Replika elérhetőség, partíciós kulcsok, feltételes írások|13|

#### **Project assessment** 
#### **A projekt értékelése**

Assessment covers the **working implementation** , **technical explanations** , **documentation** , **presentation** , and **each team member’s preparation** . Each member is expected to understand their contribution. 

Az értékelés kiterjed a **működő implementációra**, a **technikai magyarázatokra**, a **dokumentációra**, a **prezentációra**, valamint **az egyes csapattagok felkészültségére**. Elvárás, hogy minden tag értse a saját hozzájárulását.

If **at least one team member presents** the project, **all team members receive the same project grade** , including absent members. 

Ha **legalább egy csapattag előadja** a projektet, **minden csapattag ugyanazt a projektosztályzatot kapja**, a hiányzó tagokat is beleértve.

For the final grade, minimum requirements, and retakes, see the course introduction. 

A végső érdemjeggyel, a minimumkövetelményekkel és a pótlási lehetőségekkel kapcsolatban lásd a kurzus bevezetőjét.

NMI_PI130G3 

1 / 20 

NoSQL group <u>project</u> 
NoSQL csoportos <u>projekt</u>

Big Data Management and Processing 
Big Data Kezelés és Feldolgozás

## **Software access and version selection** 
## **Szoftverhozzáférés és verzióválasztás**

**Every standard track has a route without a paid database licence or cloud subscription.** Use local installations on an available computer. The Neo4j standard route uses Community Edition and a documentation-based replication analysis, not a live cluster. 

**Minden standard iránynak van olyan útvonala, amelyhez nincs szükség fizetős adatbázis-licencre vagy felhő-előfizetésre.** Használjatok helyi telepítéseket egy rendelkezésre álló számítógépen. A Neo4j standard útvonala a Community Edition változatot és dokumentációalapú replikációelemzést használ, nem pedig élő fürtöt.

The following **reference releases were checked on 27 September 2026** . They are not mandatory upgrades for an already working project. 

A következő **referencia-kiadások 2026. szeptember 27-én lettek ellenőrizve**. Ezek nem kötelező frissítések egy már működő projekt esetén.

|**Database**|**Release**|**Access and compatibility**|
|---|---|---|
|Redis|8.10.2|Redis Open Source 8.x offers an AGPLv3 licensing option. Sentinel,<br>Cluster, and command transactions are included. This reference<br>includes the 17 September security fixes. [25,26]|
|CouchDB|3.5.2|Apache License 2.0. Both local instances, replication, partitioned<br>databases, and document updates are included. [27]|
|Neo4j|2026.09.0|Community Edition is available under GPLv3. OpenJDK 21 is a<br>supported native-installation choice. Live clustering needs<br>Enterprise access and is optional. [29,12,32]|
|Cassandra|5.0.9|Apache License 2.0. Use the released 5.0 branch. OpenJDK 17<br>and Python 3.11 are supported native-installation choices. Use the<br>bundled`cqlsh`. [28,36]|

|**Adatbázis**|**Kiadás**|**Hozzáférés és kompatibilitás**|
|---|---|---|
|Redis|8.10.2|A Redis Open Source 8.x AGPLv3 licencelési lehetőséget kínál. A Sentinel,<br>Cluster és parancstranzakciók elérhetők. Ez a referenciaváltozat<br>tartalmazza a szeptember 17-i biztonsági javításokat. [25,26]|
|CouchDB|3.5.2|Apache License 2.0. Mindkét helyi példány, a replikáció, a particionált<br>adatbázisok és a dokumentumfrissítések támogatottak. [27]|
|Neo4j|2026.09.0|A Community Edition GPLv3 licenc alatt érhető el. Az OpenJDK 21 egy<br>támogatott natív telepítési opció. Az élő fürtözés (live clustering)<br>Enterprise hozzáférést igényel, és opcionális. [29,12,32]|
|Cassandra|5.0.9|Apache License 2.0. Használjátok a hivatalosan kiadott 5.0-s ágat. Az OpenJDK 17<br>és a Python 3.11 támogatott natív telepítési választások. Használjátok a<br>mellékelt `cqlsh`-t. [28,36]|

#### **Choose a reproducible version** 
#### **Reprodukálható verzió választása**

Pin an explicit released image tag or package version, not only `latest` . Record the exact version and, where possible, its digest or checksum. Check the processor architecture and use matching documentation. A suitable released patch in the same branch is acceptable. A container image can provide the database’s required runtime without changing your host Java or Python installation. 

Rögzítsetek egy pontosan megadott, kiadott image-taget vagy csomagverziót, ne csak a `latest`-et. Jegyezzétek fel a pontos verziót, és ahol lehetséges, annak digest értékét vagy ellenőrzőösszegét (checksum). Ellenőrizzétek a processzorarchitektúrát, és a megfelelő dokumentációt használjátok. Egy megfelelő, ugyanazon ágon belüli kiadott javítócsomag (patch) elfogadható. Egy konténer-image biztosítani tudja az adatbázis által megkövetelt futtatókörnyezetet anélkül, hogy megváltoztatná a gazdagépen lévő Java vagy Python telepítést.

#### **Container tools and local access** 
#### **Konténereszközök és helyi hozzáférés**

Docker Desktop is free for education under its published terms. Docker Engine on Linux is an alternative. Use software permitted on your computer or university lab machine. The standard tasks do not require Kubernetes, a paid Docker subscription, or billable cloud resources. [30] 

A Docker Desktop az oktatás számára ingyenes a közzétett feltételei alapján. Linuxon a Docker Engine egy alternatív lehetőség. Olyan szoftvert használjatok, amely engedélyezett a saját számítógépeteken vagy az egyetemi laboratóriumi gépen. A standard feladatok nem igényelnek Kubernetes-t, fizetős Docker előfizetést vagy költséggel járó felhőerőforrásokat. [30]

A cloud free tier is not a replacement for a lab in which you must configure replication or stop a specific node. Neo4j Aura Free and Aura trials are separate from the optional self-managed Enterprise route on page 17. [29] 

A felhős ingyenes csomag (free tier) nem helyettesíti azt a labort, amelyben replikációt kell konfigurálnotok, vagy le kell állítanotok egy adott csomópontot. A Neo4j Aura Free és az Aura próbaverziói függetlenek a 17. oldalon található opcionális, saját üzemeltetésű Enterprise útvonaltól. [29]

#### **Optional evaluations** 
#### **Opcionális próbaverziók (Evaluation)**

Record the licence or evaluation route in the README. For a trial, confirm that the terms cover the team, instances, and classroom demonstration. Record its expiry and finish all permitted use within the evaluation period. Software access does not provide hardware or permission to install software on a managed computer. 

Rögzítsétek a licencet vagy az értékelési (evaluation) útvonalat a README-ben. Próbaverzió esetén győződjetek meg arról, hogy a feltételek lefedik a csapatot, a példányokat és a tantermi demonstrációt. Jegyezzétek fel a lejárati idejét, és fejezzetek be minden megengedett használatot az értékelési időszakon belül. A szoftverhozzáférés nem biztosít hardvert vagy engedélyt szoftverek felügyelt gépre történő telepítésére.

NMI_PI130G3 

2 / 20 

NoSQL group <u>project</u> 
NoSQL csoportos <u>projekt</u>

Big Data Management and Processing 
Big Data Kezelés és Feldolgozás

## **1 Introduction to the database** (3 minutes) 
## **1 Az adatbázis bemutatása** (3 perc)

Introduce the selected database in relation to your project, covering: 

Mutassátok be a kiválasztott adatbázist a projektetekkel összefüggésben, kitérve a következőkre:

- **Background:** When and why it was developed, and the problem it was designed to address. Cite a reliable source for historical claims.
  
  **Háttér:** Mikor és miért fejlesztették ki, és milyen probléma megoldására tervezték. Idézzetek egy megbízható forrást a történelmi vonatkozású állításokhoz.

- **Core features:** The main data model, interfaces, and capabilities relevant to your example.
  
  **Főbb jellemzők:** A fő adatmodell, interfészek és a példátok szempontjából releváns képességek.

- **Suitability:** Why it fits your data and queries. Give at least one strength and one limitation, rather than only listing advantages.
  
  **Alkalmasság:** Miért illeszkedik az adatokhoz és a lekérdezésekhez. Adjatok meg legalább egy erősséget és egy korlátot ahelyett, hogy csak az előnyöket sorolnátok fel.

## **2 Installation and setup** (3 minutes) 
## **2 Telepítés és beállítás** (3 perc)

Document **one working installation route** for your operating system. Docker Compose or native installation is acceptable. Windows users may use Linux containers with the WSL 2 backend. You do not need to demonstrate multiple operating systems. [1] 

Dokumentáljatok **egy működő telepítési útvonalat** az operációs rendszeretekhez. A Docker Compose vagy a natív telepítés egyaránt elfogadható. A Windows felhasználók használhatnak Linux konténereket a WSL 2 háttérrendszerrel. Nem szükséges több operációs rendszert bemutatni. [1]

Show the database version, edition, and connection method. For a multi-instance setup, show its **topology** : the instances, their roles, and their network connections. 

Mutassátok be az adatbázis verzióját, kiadását és a kapcsolódás módját. Többpéldányos összeállítás esetén mutassátok be annak **topológiáját**: a példányokat, azok szerepköreit és hálózati kapcsolataikat.

- **Storage and networking:** Use separate data directories or volumes. Keep lab ports private, use reachable addresses, and keep credentials out of committed files. Inside a container, `localhost` means that container.
  
  **Tárolás és hálózatkezelés:** Használjatok külön adatkönyvtárakat vagy köteteket (volume-okat). Tartsátok a laborportokat privátként, használjatok elérhető címeket, és ne tegyetek hitelesítő adatokat a verziókövetett (commitolt) fájlokba. Egy konténeren belül a `localhost` magát a konténert jelenti.

- **Readiness and resources:** Start the full topology, verify roles or membership, and run a write/read. Check memory limits, free disk space, and logs under a small workload. Cassandra and an optional Neo4j cluster need resources for three JVMs, including memory beyond their heaps.
  
  **Készenlét és erőforrások:** Indítsátok el a teljes topológiát, ellenőrizzétek a szerepköröket vagy a tagságot, és futtassatok egy írást/olvasást. Ellenőrizzétek a memóriakorlátokat, a szabad lemezterületet és a naplófájlokat (logokat) egy kis terhelés mellett. A Cassandra és az opcionális Neo4j fürt három JVM-hez igényel erőforrásokat, beleértve a heap memórián kívüli memóriát is.

- **Recovery and reset:** Practise the failure experiment and restore the stopped instance. Use bounded readiness checks. Verify a clean reset and re-seeding procedure, and identify any commands that delete sample data.
  
  **Helyreállítás és visszaállítás (reset):** Gyakoroljátok a meghibásodási kísérletet és a leállított példány helyreállítását. Alkalmazzatok korlátos idejű készenléti ellenőrzéseket. Igazoljátok a tiszta visszaállítási és újra-feltöltési (re-seeding) eljárást, és azonosítsatok minden olyan parancsot, amely mintaadatokat töröl.

Complete these checks **before preparing the final presentation** . If the required topology cannot run reliably, contact the instructor to agree a solution before changing your assigned database. 

Ezeket az ellenőrzéseket **a végső prezentáció előkészítése előtt** végezzétek el. Ha a megkövetelt topológia nem tud megbízhatóan futni, vegyétek fel a kapcsolatot az oktatóval a megoldás egyeztetése érdekében, mielőtt megváltoztatnátok a kijelölt adatbázist.

## **3 Database structure** (2 minutes) 
## **3 Adatbázis-struktúra** (2 perc)

Show your own key layout, sample document, graph, or CQL table definition. Explain identifiers, value types, relationships or references, and the queries that shaped the design. Identify any partition key, clustering columns, or indexes. 

Mutassátok be a saját kulcsstruktúrátokat, mintadokumentumotokat, gráfotokat vagy CQL tábladefiníciótokat. Magyarázzátok el az azonosítókat, értéktípusokat, kapcsolatokat vagy hivatkozásokat, valamint azokat a lekérdezéseket, amelyek meghatározták a tervezést. Azonosítsátok a partíciós kulcsot, a klaszterező oszlopokat vagy az indexeket.

## **4 Basic queries and operations** (5 minutes) 
## **4 Alapvető lekérdezések és műveletek** (5 perc)

Demonstrate **create, read, update, and delete (CRUD)** on your sample data. For each operation, show the command or query and verify the resulting state. Include one useful query beyond retrieving a record by its identifier, using capabilities appropriate to the database. 

Mutassátok be a **létrehozást, olvasást, frissítést és törlést (CRUD)** a mintaadatokon. Minden művelethez mutassátok be a parancsot vagy lekérdezést, és ellenőrizzétek az eredményül kapott állapotot. Mutassatok be legalább egy olyan hasznos lekérdezést az azonosító szerinti egyszerű lekérésen túl, amely kihasználja az adatbázis sajátos képességeit.

Use self-generated data or a permitted public dataset/API. Keep a reproducible local sample or generator; record the source and any reuse conditions. A small, understandable dataset is enough for correctness tests. Use a separate, larger dataset only when needed for an optional timing experiment. 

Használjatok saját generálású adatokat vagy engedélyezett nyilvános adatkészletet/API-t. Tartsatok fenn egy reprodukálható helyi mintát vagy generátort; jegyezzétek fel a forrást és az esetleges újrafelhasználási feltételeket. Egy kis méretű, átlátható adatkészlet elegendő a helyességi tesztekhez. Különálló, nagyobb adatkészletet csak akkor használjatok, ha egy opcionális sebességmérést végeztek.

NMI_PI130G3 

3 / 20 

NoSQL group <u>project</u> 
NoSQL csoportos <u>projekt</u>

Big Data Management and Processing 
Big Data Kezelés és Feldolgozás

## **5 Replication, partitioning, and transactions** (11 minutes) 
## **5 Replikáció, particionálás és tranzakciók** (11 perc)

Complete the replication, partitioning/scalability, and transaction tasks in your selected track. The tasks differ because the databases do not offer identical features or guarantees. 

Végezzétek el a replikációs, particionálási/skálázhatósági és tranzakciós feladatokat a választott irányotokban. A feladatok eltérőek, mivel az adatbázisok nem azonos funkciókat vagy garanciákat nyújtanak.

#### **Local environment for each track** 
#### **Helyi környezet az egyes irányokhoz**

|**Database**|**Required lab environment**|
|---|---|
|Redis|One primary, one replica, and three Sentinel processes for failover. A separate<br>three-primary Redis Cluster, without replicas, is sufficient for the sharding experiment.<br>Run the two setups separately.|
|CouchDB|Two independent single-node instances for database-to-database replication.<br>Partitioned-query and document-update tests can run on one of them.|
|Neo4j|One Community Edition instance for the standard route. Clustering is addressed<br>through a documented architecture analysis; running an Enterprise cluster is optional.|
|Cassandra|Three nodes in one data centre. Use separate keyspaces with replication factors 3<br>and 1 for the availability and partition-placement experiments.|

|**Adatbázis**|**Megkövetelt laborkörnyezet**|
|---|---|
|Redis|Egy elsődleges (primary), egy replika és három Sentinel folyamat a feladatátvételhez. Egy különálló,<br>három elsődlegesből álló Redis Cluster (replikák nélkül) elegendő a sharding kísérlethez.<br>Futtassátok a két beállítást külön-külön.|
|CouchDB|Két független egycsomópontos példány az adatbázisok közötti replikációhoz.<br>A particionált lekérdezési és dokumentumfrissítési tesztek futhatnak az egyiken.|
|Neo4j|Egy Community Edition példány a standard útvonalhoz. A fürtözést egy dokumentált<br>architektúra-elemzés dolgozza fel; az Enterprise fürt futtatása opcionális.|
|Cassandra|Három csomópont egyetlen adatközpontban. Használjatok külön kulcstereket (keyspaces) 3-as<br>és 1-es replikációs faktorral (RF) az elérhetőségi és partíció-elhelyezési kísérletekhez.|

These are **teaching configurations** , not production deployment recommendations. Several processes on one computer demonstrate process failure, not survival of that computer’s failure. Complete the setup checks in Section 2. 

Ezek **oktatási célú konfigurációk**, nem pedig éles üzembe helyezési ajánlások. Több folyamat egyetlen számítógépen a folyamathibát mutatja be, nem pedig azt, hogy a rendszer túléli-e a gép meghibásodását. Végezzétek el a 2. fejezetben szereplő beállítási ellenőrzéseket.

#### **For every experiment** 
#### **Minden kísérletre vonatkozóan**

Each track uses the same four parts: **A. Setup and data model** , **B. Replication** , **C. Partitioning or scalability** , and **D. Transactions** . Complete all required parts of your track. Optional extensions are not needed for a complete submission. 

Mindegyik irány ugyanazt a négy részt követi: **A. Beállítás és adatmodell**, **B. Replikáció**, **C. Particionálás vagy skálázhatóság**, és **D. Tranzakciók**. Végezzétek el az irányotok összes kötelező részét. Az opcionális kiterjesztések nem szükségesek a teljes beadáshoz.

For each experiment, record the starting state, action, expected result, observed result, and interpretation. Identify the instance or connection in the evidence. A stopped node, a paused replication job, and a network partition are different tests. A network partition blocks communication between running nodes. It is not data partitioning. 

Minden kísérletnél rögzítsétek a kiinduló állapotot, a végrehajtott műveletet, a várt eredményt, a megfigyelt eredményt és az értelmezést. Azonosítsátok a példányt vagy kapcsolatot a bizonyítékokban. Egy leállított csomópont, egy szüneteltetett replikációs feladat és egy hálózati partíció (szakadás) különböző tesztek. A hálózati partíció blokkolja a futó csomópontok közötti kommunikációt. Ez nem azonos az adatok particionálásával.

#### **Performance comparisons** 
#### **Teljesítmény-összehasonlítások**

A speed improvement is **not a required outcome** . If you measure performance, compare equivalent queries and results on the same data, document indexes and configuration, warm up the system, repeat the measurement, and report variation as well as a typical value. Do not present a single-laptop experiment as proof of production scalability. A result showing no clear improvement is valid when explained. 

A sebességnövekedés elérése **nem kötelező elvárás**. Ha mértek teljesítményt, hasonlítsatok össze egyenértékű lekérdezéseket és eredményeket azonos adatokon, dokumentáljátok az indexeket és a konfigurációt, melegítsétek be a rendszert, ismételjétek meg a mérést, és számoljatok be a szórásról, valamint a tipikus értékről is. Ne mutassatok be egyetlen laptopon végzett kísérletet az éles skálázhatóság bizonyítékaként. Egy olyan eredmény, amely nem mutat egyértelmű javulást, teljesen elfogadható, ha meg van magyarázva.

#### **Practical demonstration and supporting evidence** 
#### **Gyakorlati bemutató és alátámasztó bizonyítékok**

Demonstrate CRUD and **at least one representative advanced operation live** . All required practical experiments must be implemented, but not every step must run live. Use your team’s logs, screenshots, or a short recording for longer experiments. Label documentation-based Neo4j analysis separately from measured results. 

Mutassátok be a CRUD műveleteket és **legalább egy reprezentatív fejlett műveletet élőben**. Minden kötelező gyakorlati kísérletet meg kell valósítani, de nem minden lépésnek kell élőben lefutnia. A hosszabb kísérletekhez használjátok a csapat naplófájljait (logjait), képernyőképeket vagy egy rövid videofelvételt. A dokumentációalapú Neo4j elemzést jelöljétek külön a mért eredményektől.

The sample commands illustrate specific tests, not a complete project solution. Replace connection placeholders and use your own data where appropriate. Keep complete commands and outputs in the project materials, and select the important results for the presentation. 

A mintaparancsok konkrét teszteket szemléltetnek, nem egy teljes projektmegoldást. Helyettesítsétek a kapcsolati helyőrzőket, és használjatok saját adatokat, ahol szükséges. Őrizzétek meg a teljes parancsokat és kimeneteket a projektanyagai között, és a fontos eredményeket válasszátok ki a prezentációhoz.

NMI_PI130G3 

4 / 20 

NoSQL group <u>project</u> 
NoSQL csoportos <u>projekt</u>

Big Data Management and Processing 
Big Data Kezelés és Feldolgozás

### **5.4 Apache Cassandra** 
### **5.4 Apache Cassandra**

**Required:** Three nodes in one data centre, availability at different consistency levels, partition-key placement, and a lightweight transaction. Use the released Cassandra 5.0 branch and matching documentation. [28] 

**Követelmény:** Három csomópont egyetlen adatközpontban, rendelkezésre állás különböző konzisztenciaszinteken, partíciós kulcsok elhelyezése és egy könnyűsúlyú tranzakció (lightweight transaction - LWT). Használjátok a hivatalosan kiadott Cassandra 5.0-s ágat és a hozzá tartozó dokumentációt. [28]

#### **A. Setup and data model** 
#### **A. Beállítás és adatmodell**

Start three nodes with the same cluster and data-centre names, distinct storage and addresses, and consistent seed configuration. Start them in a controlled sequence. Verify CQL connectivity and schema agreement, and confirm that all appear as `UN` (up/normal) in `nodetool status` . Record the actual data-centre name and use the bundled `cqlsh` . [36, 24] 

Indítsatok el három csomópontot azonos fürt- és adatközpont-névvel, külön tárterülettel és címmel, valamint egységes seed (mag) konfigurációval. Indítsátok el őket ellenőrzött sorrendben. Ellenőrizzétek a CQL kapcsolatot és a sémaegyezés meglétét (schema agreement), és győződjetek meg arról, hogy mindegyik `UN` (up/normal) állapotban jelenik meg a `nodetool status` kimenetében. Jegyezzétek fel a tényleges adatközpont-nevet, és használjátok a mellékelt `cqlsh`-t. [36, 24]

Create your keyspaces **after all three nodes have joined** . The following assumes the data centre is named `dc1` ; replace it with your actual name if different. [19] 

A kulcstereket (keyspaces) **azután hozzátok létre, hogy mindhárom csomópont csatlakozott**. A következők feltételezik, hogy az adatközpont neve `dc1`; helyettesítsétek a tényleges névvel, ha eltér. [19]

|`CREATE KEYSPACE nosql_rf3`<br>`WITH replication = {'class': `|`'NetworkTopologyStrategy', 'dc1': 3};`|
|---|---|
|`CREATE KEYSPACE nosql_rf1`||
|`WITH replication = {'class': `|`'NetworkTopologyStrategy', 'dc1': 1};`|

The suffixes indicate the **replication factor (RF)** . Use `nosql_rf3` for availability and transaction tests, and `nosql_rf1` only for the placement experiment. Separate keyspaces avoid changing an existing keyspace’s replication factor during the exercise. 

A toldalékok a **replikációs faktort (RF)** jelzik. Használjátok a `nosql_rf3`-at az elérhetőségi és tranzakciós tesztekhez, a `nosql_rf1`-et pedig kizárólag az elhelyezési (placement) kísérlethez. A különálló kulcsterek használatával elkerülhető egy meglévő kulcstér replikációs faktorának menet közbeni módosítása a feladat során.

Use Cassandra Query Language (CQL) to define a table, demonstrate CRUD, and retrieve several rows from one partition. Explain the partition key and any clustering columns. Ordinary `INSERT` and `UPDATE` operations are upserts, not existence checks. [20] 

Használjátok a Cassandra Query Language (CQL) nyelvet tábla definiálására, a CRUD műveletek bemutatására, valamint több sor lekérésére egyetlen partícióból. Magyarázzátok el a partíciós kulcsot (partition key) és a klaszterező oszlopokat (clustering columns). A szokásos `INSERT` és `UPDATE` műveletek úgynevezett „upsert”-ek (beszúrás vagy felülírás), nem pedig létezésellenőrzések. [20]

#### **B. Replication and availability** 
#### **B. Replikáció és rendelkezésre állás**

Use replication factor 3 in `nosql_rf3` . It sets the number of replicas. The **consistency level** sets the required responses: `LOCAL_QUORUM` needs two replicas here, while `ALL` needs three. Cassandra has no single primary for ordinary reads and writes. A contacted node can coordinate an operation. [21] 

Használjatok 3-as replikációs faktort a `nosql_rf3` kulcstérben. Ez határozza meg a replikák számát. A **konzisztenciaszint (consistency level)** határozza meg a megkövetelt válaszok számát: a `LOCAL_QUORUM` itt két replikát igényel, míg az `ALL` hármat. A Cassandrában nincs kijelölt egyetlen elsődleges a szokásos olvasásokhoz és írásokhoz. Bármely megkeresett csomópont koordinálhatja a műveletet. [21]

Commands such as `CONSISTENCY ALL;` are `cqlsh` settings. Apply them in the same session as the following query. They are not CQL statements to send through a driver. [24] 

Az olyan parancsok, mint a `CONSISTENCY ALL;`, `cqlsh` beállítások. Ugyanabban a munkamenetben adjátok ki őket, mint az azt követő lekérdezést. Ezek nem adatbázis-illesztőprogramon (driveren) keresztül küldendő CQL utasítások. [24]

1. With all nodes healthy, seed a small test record using `CONSISTENCY ALL` and verify it. This establishes the pre-failure record on all three replicas. 
   
   Amikor minden csomópont hibátlanul működik, szúrjatok be egy kis tesztrekordot `CONSISTENCY ALL` beállítással, és ellenőrizzétek azt. Ez létrehozza a hiba előtti rekordot mind a három replikán.

2. Connect `cqlsh` to a node that you will keep running. Stop **one other node** , then wait for failure detection. 
   
   Csatlakozzatok `cqlsh`-sel ahhoz a csomóponthoz, amelyet folyamatosan futni hagytok. Állítsatok le **egy másik csomópontot**, majd várjátok meg a hiba észlelését.

3. Use `CONSISTENCY LOCAL_QUORUM` . Read the record, write a new value, and read it back. With two healthy replicas in the one-data-centre setup, these operations should remain possible. 
   
   Alkalmazzatok `CONSISTENCY LOCAL_QUORUM` beállítást. Olvassátok be a rekordot, írjatok be egy új értéket, és olvassátok vissza. Az egyetlen adatközpontban lévő két működőképes replikával ezeknek a műveleteknek továbbra is végrehajthatóknak kell lenniük.

4. Set `CONSISTENCY ALL` and perform a **read** of the same record. Record the unavailable/timeout result: three replica responses cannot be obtained while a node remains down. Do not use an `ALL` write failure as proof that no replica changed. 
   
   Állítsátok be a `CONSISTENCY ALL` szintet, és hajtsatok végre egy **olvasást** ugyanezen a rekordon. Rögzítsétek a nem elérhető/időtúllépéses (timeout) eredményt: három replika válasza nem szerezhető meg, amíg az egyik csomópont le van állva. Ne tekintsétek az `ALL` írási hibát annak bizonyítékaként, hogy egyetlen replika sem módosult.

5. Restore the stopped node and verify that an `ALL` read returns the post-failure value. Inspect recovery logs or hint delivery. The read may trigger read repair, so it does not prove that all data was already synchronised. If recovery stalls, inspect the documented repair procedure. [37, 40] 
   
   Állítsátok vissza a leállított csomópontot, és ellenőrizzétek, hogy az `ALL` szintű olvasás a hiba utáni értéket adja-e vissza. Vizsgáljátok meg a helyreállítási naplókat vagy a célzott kézbesítést (hinted handoff). Az olvasás kiválthat olvasás közbeni javítást (read repair), így ez nem bizonyítja, hogy minden adat már korábban szinkronizálva volt. Ha a helyreállítás megakad, tekintsétek át a dokumentált repair eljárást. [37, 40]

**Evidence to present:** Cluster status and replication settings, a successful `LOCAL_QUORUM` read/write with one node down, the failed `ALL` read, and successful recovery. The client must remain connected to a live node. 

**Bemutatandó bizonyítékok:** A fürt állapota és a replikációs beállítások, a sikeres `LOCAL_QUORUM` olvasás/írás egy kiesett csomópont mellett, a sikertelen `ALL` olvasás és a sikeres helyreállítás. A kliensnek mindvégig egy élő csomóponthoz kell kapcsolódnia.

NMI_PI130G3 

13 / 20 

NoSQL group <u>project</u> 
NoSQL csoportos <u>projekt</u>

Big Data Management and Processing 
Big Data Kezelés és Feldolgozás

### **Cassandra: partition-key design and placement** 
### **Cassandra: partíciós kulcs tervezése és elhelyezése**

#### **C. Partition-key design and placement** 
#### **C. Partíciós kulcs tervezése és elhelyezése**

Use the same three-node cluster but **the fresh RF 1 keyspace** , `nosql_rf1` . With only three nodes and RF 3, all three nodes hold replicas of every partition; that configuration is unsuitable for illustrating disjoint replica placement. 

Használjátok ugyanazt a háromcsomópontos fürtöt, de **az új, 1-es replikációs faktorú (RF 1) kulcsteret**, a `nosql_rf1`-et. Csupán három csomópont és 3-as RF mellett mind a három csomópont tartalmazza minden partíció másolatát; ez az elrendezés nem alkalmas a diszjunkt replika-elhelyezés szemléltetésére.

1. Generate registrations for several events. State the intended query, such as “list all registrations for event E1”. 
   
   Generáljatok regisztrációkat több eseményhez. Határozzátok meg a megvalósítandó lekérdezést, például: „listázza az összes regisztrációt az E1 eseményhez”.

2. Design a table with `event_id` as the partition key and a registration or seat identifier as a clustering column. Load the data and run the intended query. 
   
   Tervezzetek egy táblát, amelyben az `event_id` a partíciós kulcs, és egy regisztrációs vagy ülésazonosító a klaszterező oszlop. Töltsétek be az adatokat, és futtassátok a tervezett lekérdezést.

3. Compare it with a deliberately poor design that places all registrations under a single constant partition key. You may use a small separate table for this comparison. 
   
   Hasonlítsátok össze egy szándékosan rossz tervezéssel, amely az összes regisztrációt egyetlen konstans partíciós kulcs alá helyezi. Használhattok egy kisebb külön táblát ehhez az összehasonlításhoz.

4. Count distinct primary keys per partition in the generated data. Show how the designs change partition sizes and where requests would concentrate. Do not count repeated upserts as additional stored rows. 
   
   Számoljátok meg a partíciónkénti egyedi elsődleges kulcsokat a generált adatokban. Mutassátok be, hogyan változtatják meg a tervek a partíciók méretét, és hol összpontosulnának a kérések. Ne számoljátok az ismételt felülírásokat (upsert) további tárolt sorként.

5. For several partition keys, use `nodetool getendpoints <keyspace> <table> <key>` . With a single text partition key, pass the actual value, such as `E1` . Collect keys on different nodes and record a partition-key–node table. This shows the assigned replica endpoints, not the coordinator that happened to answer a query. [24] 
   
   Több partíciós kulcsra futtassátok le a `nodetool getendpoints <keyspace> <table> <key>` parancsot. Egyetlen szöveges partíciós kulcs esetén a tényleges értéket adjátok át, például: `E1`. Gyűjtsetek össze különböző csomópontokon elhelyezkedő kulcsokat, és rögzítsetek egy partíciós kulcs–csomópont táblázatot. Ez a hozzárendelt replika-végpontokat mutatja, nem azt a koordinátort, amely történetesen válaszolt a lekérdezésre. [24]

**Evidence to present:** Both table definitions, the intended query, a comparison of partition sizes, and observed placement of several RF 1 partitions. 

**Bemutatandó bizonyítékok:** Mindkét tábladefiníció, a célzott lekérdezés, a partícióméretek összehasonlítása és több RF 1 partíció megfigyelt elhelyezkedése.

The partition key determines the token used for placement; clustering columns organise rows within a partition. Good keys must support the required queries while avoiding excessively large or heavily accessed partitions. More distinct keys do not guarantee perfectly even workload, and a popular event can still create a hot partition. [22, 21] 

A partíciós kulcs határozza meg az elhelyezéshez használt tokent; a klaszterező oszlopok a partíción belül rendezik a sorokat. A jó kulcsoknak támogatniuk kell a szükséges lekérdezéseket, elkerülve a túlzottan nagy vagy túlterhelt (hot) partíciókat. A több egyedi kulcs nem garantál teljesen egyenletes terhelést, és egy népszerű esemény továbbra is létrehozhat egy forró (hot) partíciót. [22, 21]

#### **Keep the two experiments separate** 
#### **A két kísérletet tartsátok külön**

RF 1 provides no redundant copy. Keep all nodes running during the placement experiment. 

Az 1-es replikációs faktor (RF 1) nem biztosít redundáns másolatot. Tartsátok az összes csomópontot futva az elhelyezési kísérlet során.

NMI_PI130G3 

14 / 20 

NoSQL group <u>project</u> 
NoSQL csoportos <u>projekt</u>

Big Data Management and Processing 
Big Data Kezelés és Feldolgozás

### **Cassandra: lightweight transactions** 
### **Cassandra: könnyűsúlyú tranzakciók (LWT)**

#### **D. Conditional updates with LWT** 
#### **D. Feltételes frissítések LWT-vel**

A lightweight transaction (LWT) supports a conditional change, such as claiming an unreserved seat. It is **not a general multi-row SQL transaction** . The required experiment uses a single row, making the scope explicit. [20, 23] 

A könnyűsúlyú tranzakció (Lightweight Transaction - LWT) egy feltételes módosítást támogat, mint például egy még le nem foglalt ülőhely lefoglalása. Ez **nem egy általános, több sorra kiterjedő SQL tranzakció**. A megkövetelt kísérlet egyetlen sort használ, egyértelművé téve a hatókört. [20, 23]

Create this table in the RF 3 keyspace. Run the example on ordinary, non-counter columns: 

Hozzátok létre ezt a táblát az RF 3 kulcstérben. Futtassátok a példát szokásos, nem számláló (non-counter) oszlopokon:

```
CREATETABLEnosql_rf3.seat_claims(
event_idtext,
seat_noint,
ownertext,
PRIMARYKEY(event_id,seat_no)
);
```

Here, `event_id` is the partition key and `seat_no` is a clustering column. Use a fresh event identifier for each test run so that the chosen seat is initially unclaimed. 

Itt az `event_id` a partíciós kulcs, a `seat_no` pedig egy klaszterező oszlop. Használjatok új eseményazonosítót minden tesztfutáshoz, hogy a kiválasztott hely kezdetben lefoglalatlan legyen.

1. Restore all three nodes before the LWT test. Open two `cqlsh` sessions or equivalent independent client connections. 
   
   Állítsátok helyre mindhárom csomópontot az LWT teszt előtt. Nyissatok két `cqlsh` munkamenetet vagy azzal egyenértékű független klienskapcsolatot.

2. In each session, run `CONSISTENCY LOCAL_QUORUM;` and `SERIAL CONSISTENCY LOCAL_SERIAL;` for this single-data-centre experiment. 
   
   Mindkét munkamenetben adjátok ki a `CONSISTENCY LOCAL_QUORUM;` és a `SERIAL CONSISTENCY LOCAL_SERIAL;` parancsokat ehhez az egy-adatközpontos kísérlethez.

3. Attempt the same conditional claim from both clients, using different owner values. First run the attempts in a controlled order; simultaneous attempts are an optional extension. 
   
   Kíséreljétek meg ugyanazt a feltételes foglalást mindkét kliensről eltérő tulajdonos (owner) értékekkel. Először ellenőrzött sorrendben futtassátok a kísérleteket; az egyidejű kísérletek opcionális kiterjesztést jelentenek.

```
--ClientA,forapreviouslyunusedevent/seat:
INSERTINTOnosql_rf3.seat_claims(event_id,seat_no,owner)
VALUES('demo-run-001',1,'Alice')IFNOTEXISTS;
```

```
--ClientB,usingthesameevent/seat:
INSERTINTOnosql_rf3.seat_claims(event_id,seat_no,owner)
VALUES('demo-run-001',1,'Bob')IFNOTEXISTS;
```

With the clients run in this order and no failures, the first result should have `[applied] = true` ; the second should have `[applied] = false` . Read the row and verify that the first claim was not overwritten. A concurrent run need not have the same winner. 

Ha a kliensek ebben a sorrendben futnak le és nincs hiba, az első eredménynek a `[applied] = true` értéket kell adnia; a másodiknak a `[applied] = false` értéket. Olvassátok be a sort, és ellenőrizzétek, hogy az első foglalás nem lett felülírva. Egy egyidejű futtatás esetén nem feltétlenül ugyanaz lesz a győztes.

**Evidence to present:** Both conditional results, the final owner, and the normal/serial consistency settings. Explain how ordinary upserts would differ from `IF NOT EXISTS` . 

**Bemutatandó bizonyítékok:** Mindkét feltételes eredmény, a végső tulajdonos, valamint a normál és soros (serial) konzisztenciabeállítások. Magyarázzátok el, miben különbözne a szokásos upsert az `IF NOT EXISTS` záradéktól.

LWT requires additional coordination. A normal consistency level and a serial consistency level serve different phases of the conditional operation. A timeout can leave the outcome uncertain, so it is not equivalent to `[applied] = false` . Do not mix ordinary writes with competing conditional writes to this test row. [20, 24] 

Az LWT további koordinációt igényel. A normál konzisztenciaszint és a soros (serial) konzisztenciaszint a feltételes művelet különböző szakaszait szolgálja ki. Egy időtúllépés (timeout) bizonytalanságban hagyhatja a kimenetelt, így nem egyenértékű a `[applied] = false` eredménnyel. Ne keverjétek a szokásos írásokat a versenyző feltételes írásokkal ezen a tesztsoron. [20, 24]

#### **Do not confuse LWT with BATCH** 
#### **Ne tévesszétek össze az LWT-t a BATCH-csel**

A logged `BATCH` supports eventual completion of its mutations, but is not a general SQL transaction with cross-partition isolation. Keep batch behaviour separate from the conditional single-row guarantee demonstrated here. Multi-row conditional batches are outside the required task. [20] 

A naplózott `BATCH` biztosítja a benne lévő módosítások végleges befejezését (eventual completion), de nem egy partíciókon átívelő izolációval rendelkező általános SQL tranzakció. A kötegelt műveletek (batch) viselkedését kezeljétek külön az itt bemutatott feltételes egysoros garanciától. A több sorra kiterjedő feltételes batch műveletek kívül esnek a kötelező feladaton. [20]

NMI_PI130G3 

15 / 20 

NoSQL group <u>project</u> 
NoSQL csoportos <u>projekt</u>

Big Data Management and Processing 
Big Data Kezelés és Feldolgozás

## **6 Conclusion** (1 minute) 
## **6 Összegzés** (1 perc)

Summarise what your implementation demonstrated. Identify a realistic use case, one useful strength, and one important limitation of the selected database. Connect these conclusions to your data model and observed results rather than making unsupported claims about general superiority. 

Foglaljátok össze, mit mutatott be az implementációtok. Azonosítsatok egy életszerű felhasználási esetet (use case), a kiválasztott adatbázis egy hasznos erősségét és egy fontos korlátját. Kapcsoljátok ezeket a következtetéseket az adatmodellhez és a megfigyelt eredményekhez, ahelyett, hogy megalapozatlan állításokat tennétek az általános felsőbbrendűségéről.

## **Project materials** 
## **Projektanyagok**

Prepare one clearly organised folder or repository containing: 

Készítsetek elő egy átláthatóan megszervezett mappát vagy repository-t, amely a következőket tartalmazza:

- **Presentation:** The slides used for the six-part presentation, with sources collected at the end.
  
  **Prezentáció:** A hatrészes előadáshoz használt diák, a végén összegyűjtött forrásokkal.

- **Setup instructions:** A README recording the operating system, database version/edition, prerequisites, licence/evaluation route, service topology, start/connect/stop/reset steps, and relevant resource settings. Include trial expiry where applicable.
  
  **Beállítási útmutató:** Egy README, amely rögzíti az operációs rendszert, az adatbázis verzióját/kiadását, az előfeltételeket, a licencelési/próbaverziós utat, a szolgáltatási topológiát, az indítási/kapcsolódási/leállítási/visszaállítási (reset) lépéseket és a releváns erőforrás-beállításokat. Tüntessétek fel a próbaverzió lejáratát is, ahol releváns.

- **Reproducible examples:** Configuration files, database definitions where applicable, data or a generator, and the commands/scripts used for CRUD and the required experiments.
  
  **Reprodukálható példák:** Konfigurációs fájlok, adatbázis-definíciók (ahol releváns), adatok vagy adatgenerátor, valamint a CRUD műveletekhez és a kötelező kísérletekhez használt parancsok/scriptek.

- **Evidence:** Before/after output, relevant logs or screenshots, and a short explanation of expected versus observed results. Include any measurements as data, not only a chart.
  
  **Bizonyítékok:** Művelet előtti és utáni kimenetek, vonatkozó naplófájlok vagy képernyőképek, valamint a várt és a megfigyelt eredmények rövid magyarázata. Bármilyen mérést adatokként is tüntessetek fel, ne csak diagramként.

- **Attribution and contributions:** Dataset/documentation sources and a brief account of each team member’s work. Provide a credential template without real passwords or tokens.
  
  **Forrásmegjelölés és hozzájárulások:** Az adatkészlet/dokumentáció forrásai és az egyes csapattagok elvégzett munkájának rövid ismertetése. Készítsetek egy hitelesítőadat-sablont valódi jelszavak vagy tokenek nélkül.

Follow the course announcement for the upload location and exact submission deadline. 

A feltöltés helyével és a pontos leadási határidővel kapcsolatban kövessétek a kurzus hirdetményeit.

#### **Experiment record template** 
#### **Kísérleti jegyzőkönyv sablon**

|**Field**|**What to record**|
|---|---|
|Configuration|Version, edition, instances, data and relevant settings.|
|Action|The exact request, command sequence or stopped service.|
|Expected result|A concrete state, reply, error or role change.|
|Observed result|Actual output, values, roles and timing where measured.|
|Interpretation|The supported conclusion and any remaining limitation.|

|**Mező**|**Mit kell rögzíteni**|
|---|---|
|Konfiguráció (Configuration)|Verzió, kiadás, példányok, adatok és releváns beállítások.|
|Művelet (Action)|A pontos kérés, parancssorozat vagy leállított szolgáltatás.|
|Várt eredmény (Expected result)|Konkrét állapot, válasz, hiba vagy szerepkörváltozás.|
|Megfigyelt eredmény (Observed result)|Tényleges kimenet, értékek, szerepkörök és időzítés (ahol mértétek).|
|Értelmezés (Interpretation)|Az alátámasztott következtetés és az esetlegesen fennmaradó korlát.|

## **Final check before presenting** 
## **Végső ellenőrzés a prezentáció előtt**

Rehearse the complete 25-minute sequence, including transitions. Keep the services, local data, prepared commands, and evidence ready. Check that the examples work from the documented starting state and that the presenter can explain the model, results, and limitations. Do not depend on a live external API. 

Próbáljátok el a teljes 25 perces előadást, az átkötéseket is beleértve. Tartsátok készenlétben a szolgáltatásokat, a helyi adatokat, az előkészített parancsokat és a bizonyítékokat. Ellenőrizzétek, hogy a példák a dokumentált kiindulási állapotból működnek-e, és hogy az előadó képes-e elmagyarázni a modellt, az eredményeket és a korlátokat. Ne függjetek élő külső API-tól.

NMI_PI130G3 

16 / 20 

NoSQL group <u>project</u> 
NoSQL csoportos <u>projekt</u>

Big Data Management and Processing 
Big Data Kezelés és Feldolgozás

## **Optional appendix: Neo4j Enterprise evaluation** 
## **Opcionális függelék: Neo4j Enterprise próbaverzió (Evaluation)**

**Optional route only.** Complete the required Community-compatible tasks first. Choose this extension only after confirming evaluation access and a working three-server environment. 

**Kizárólag opcionális útvonal.** Először végezzétek el a kötelező, Community-kompatibilis feladatokat. Csak azután válasszátok ezt a kiterjesztést, miután megerősítettétek a próbaverziós hozzáférést és a működő háromszerveres környezetet.

#### **Access and expiry** 
#### **Hozzáférés és lejárat**

The Software Evaluation Agreement allows one or more JVM instances for internal evaluation, normally for **30 days** unless the applicable request or order specifies otherwise. Confirm that the authorised users, instances, and classroom demonstration are covered. Record the licensee and dates. An individual trial does not automatically authorise shared team access. [31] 

A Szoftverértékelési Szerződés (Software Evaluation Agreement) egy vagy több JVM példányt engedélyez belső értékelésre, általában **30 napra**, kivéve, ha a vonatkozó kérelem vagy megrendelés másként rendelkezik. Győződjetek meg arról, hogy a felhatalmazott felhasználók, a példányok és a tantermi demonstráció lefedettek-e. Rögzítsétek a licenc birtokosát és a dátumokat. Az egyéni próbaverzió nem jogosít automatikusan megosztott csapathozzáférésre. [31]

Neo4j Desktop’s free developer licence is a different arrangement, restricted to a named user and the permitted local-machine use. It is not automatically a shared team or multi-machine Enterprise licence. Aura’s hosted free/trial offerings are also separate from this self-managed route. [33, 29] 

A Neo4j Desktop ingyenes fejlesztői licence más konstrukció: egy megnevezett felhasználóra és az engedélyezett helyi gépi használatra korlátozódik. Ez nem jelent automatikusan megosztott csapatos vagy többgépes Enterprise licencet. Az Aura felhős ingyenes/próbaverziós ajánlatai szintén függetlenek ettől a saját üzemeltetésű útvonaltól. [33, 29]

#### **Activation is not a substitute for permission** 
#### **Az aktiválás nem helyettesíti az engedélyt**

For a native Enterprise installation, the official instructions distinguish the evaluation option from commercial acceptance. After checking and accepting the applicable evaluation terms, the documented command is: 

Natív Enterprise telepítés esetén a hivatalos útmutató megkülönbözteti az értékelési (evaluation) lehetőséget a kereskedelmi elfogadástól. A vonatkozó értékelési feltételek ellenőrzése és elfogadása után a dokumentált parancs a következő:

```
neo4j-adminserverlicense--accept-evaluation
```

The documented evaluation environment value is `NEO4J_ACCEPT_LICENSE_AGREEMENT=eval` . Do not copy the commercial value `yes` from a deployment example and treat it as a free licence. Confirm the activation route for the selected distribution. After expiry, stop using and uninstall the evaluation software unless a valid extension or other licence applies. [32] 

A dokumentált értékelési környezeti változó értéke `NEO4J_ACCEPT_LICENSE_AGREEMENT=eval`. Ne másoljátok át a kereskedelmi `yes` értéket egy üzembe helyezési példából, ingyenes licencként kezelve azt. Erősítsétek meg az aktiválási útvonalat a választott disztribúcióhoz. A lejárat után fejezzétek be a használatot, és távolítsátok el az értékelési szoftvert, kivéve, ha érvényes hosszabbítás vagy más licenc vonatkozik rá. [32]

#### **Three-primary experiment** 
#### **Három-elsődlegeses kísérlet**

1. Use the official local-cluster tutorial for the selected release. Keep exactly three primary-capable servers for the required test topology. A secondary is optional. Use separate storage and reachable private addresses. [34] 
   
   Használjátok a kiválasztott kiadáshoz tartozó hivatalos helyi fürt útmutatót (local-cluster tutorial). Tartsatok pontosan három elsődlegesre képes szervert a megkövetelt teszttopológiához. A másodlagos (secondary) szerver opcionális. Használjatok külön háttértárat és elérhető privát címeket. [34]

2. Pin one Enterprise version for all members. Check configuration, permissions, and memory. Apply the evaluation route to each instance as required. Keep client and cluster ports private. 
   
   Rögzítsetek egyetlen Enterprise verziót az összes tag számára. Ellenőrizzétek a konfigurációt, a jogosultságokat és a memóriát. Alkalmazzátok az értékelési útvonalat minden példányra szükség szerint. Tartsátok a kliens- és fürtportokat privátként.

3. Confirm server health with `SHOW SERVERS` and inspect the target database with `SHOW DATABASES` . Verify that it actually has three online primary copies, not only that three processes have started. 
   
   Erősítsétek meg a szerverek működőképességét a `SHOW SERVERS` paranccsal, és vizsgáljátok meg a céladatbázist a `SHOW DATABASES` paranccsal. Ellenőrizzétek, hogy valóban három online elsődleges másolata van-e, nem csupán azt, hogy három folyamat elindult.

4. Write connected sample data using a routing-capable client. Verify the result and record the writer for _that database_ . Different databases can have different leaders. [15] 
   
   Írjatok be összefüggő mintaadatokat egy útválasztásra képes (routing-capable) kliens használatával. Ellenőrizzétek az eredményt, és rögzítsétek _az adott adatbázis_ íróját (writer). A különböző adatbázisoknak különböző vezetői (leaderjei) lehetnek. [15]

5. Stop only that writer’s process/container. Keep the other two primaries running. Observe reelection, reconnect or retry through the routing client, and verify a fresh write and subsequent read. Record any interruption rather than promising a fixed failover time. 
   
   Állítsátok le kizárólag az adott író folyamatát/konténerét. Tartsátok futva a másik két elsődlegest. Figyeljétek meg az újraválasztást, csatlakozzatok újra vagy próbáljátok újra a műveletet az útválasztó kliensen keresztül, és igazoljátok az új írást, valamint a rákövetkező olvasást. Rögzítsetek minden megszakadást ahelyett, hogy fix átállási időt ígérnétek.

6. Restore the stopped member and confirm recovery. Save logs and before/after roles while the evaluation is valid. 
   
   Állítsátok vissza a leállított tagot, és erősítsétek meg a helyreállást. Mentsétek el a naplófájlokat és az előtte/utána szerepköröket, amíg az értékelési időszak érvényes.

**Evidence to present:** The authorised evaluation route and dates, target-database topology, writer before/after failure, and a successful post-failover write. A one-computer run demonstrates process failure, not survival of that computer’s failure. 

**Bemutatandó bizonyítékok:** A felhatalmazott értékelési út és a dátumok, a céladatbázis topológiája, az író a hiba előtt és után, valamint egy sikeres feladatátvétel utáni írás. Az egyetlen gépen történő futtatás a folyamathibát szemlélteti, nem pedig a számítógép hardveres meghibásodásának túlélését.

If evaluation access or resources are unavailable, retain the standard documentation-based replication analysis. Do not claim a cluster experiment that was not run. 

Amennyiben az értékelési hozzáférés vagy az erőforrások nem állnak rendelkezésre, tartsátok meg a standard dokumentációalapú replikációelemzést. Ne hivatkozzatok olyan fürtkísérletre, amelyet valójában nem hajtottatok végre.

NMI_PI130G3 

17 / 20 

NoSQL group <u>project</u> 
NoSQL csoportos <u>projekt</u>

Big Data Management and Processing 
Big Data Kezelés és Feldolgozás

## **Selected documentation** 
## **Kiválasztott dokumentáció**

- [1] Docker. _Docker Desktop WSL 2 backend on Windows_ . 
  _Docker Desktop WSL 2 háttérrendszer Windowson._

https://docs.docker.com/desktop/features/wsl/ 

- [2] Redis. _Redis replication_ . 
  _Redis replikáció._

https://redis.io/docs/latest/operate/oss_and_stack/management/replication/ 

- [3] Redis. _High availability with Redis Sentinel_ . 
  _Magas szintű rendelkezésre állás Redis Sentinellel._

https://redis.io/docs/latest/operate/oss_and_stack/management/sentinel/ 

- [4] Redis. _Scale with Redis Cluster_ . 
  _Skálázás Redis Clusterrel._

https://redis.io/docs/latest/operate/oss_and_stack/management/scaling/ 

- [5] Redis. _Transactions_ . 
  _Tranzakciók._

https://redis.io/docs/latest/develop/using-commands/transactions/ Command details: WATCH; EXEC. 
Részletes parancsleírások: WATCH; EXEC.

- [6] Apache CouchDB. _Single Node Setup_ ; _Installation via Docker_ . 
  _Egynode-os telepítés_; _Telepítés Dockerrel._
  
https://docs.couchdb.org/en/stable/setup/single-node.html https://docs.couchdb.org/en/stable/install/docker.html 

- [7] Apache CouchDB. _Introduction to Replication_ . 
  _Bevezetés a replikációba._

https://docs.couchdb.org/en/stable/replication/intro.html 

- [8] Apache CouchDB. _Replication and conflict model_ . 
  _Replikációs és konfliktusmodell._

https://docs.couchdb.org/en/stable/replication/conflicts.html 

- [9] Apache CouchDB. _Partitioned Databases_ . 
  _Particionált adatbázisok._

https://docs.couchdb.org/en/stable/partitioned-dbs/index.html 

- [10] Apache CouchDB. _Mango: /{db}/_find and indexes_ . 
  _Mango: /{db}/_find és indexek._

https://docs.couchdb.org/en/stable/api/database/find.html 

- [11] Apache CouchDB. _Bulk Documents Transaction Semantics_ . 
  _Tömeges dokumentumműveletek tranzakciós szemantikája._

https://docs.couchdb.org/en/stable/api/database/bulk-api.html#bulk-documents-transaction-semantics 

NMI_PI130G3 

18 / 20 

NoSQL group <u>project</u> 
NoSQL csoportos <u>projekt</u>

Big Data Management and Processing 
Big Data Kezelés és Feldolgozás

- [12] Neo4j. _Operations Manual: Introduction and editions_ . 
  _Üzemeltetési kézikönyv: Bevezetés és kiadások._

https://neo4j.com/docs/operations-manual/current/introduction/ 

- [13] Neo4j. _Getting started with Neo4j in Docker_ . 
  _Első lépések a Neo4j-vel Dockerben._

https://neo4j.com/docs/operations-manual/current/docker/introduction/ 

- [14] Neo4j. _Cypher Manual_ . 
  _Cypher kézikönyv._

https://neo4j.com/docs/cypher-manual/current/ 

- [15] Neo4j. _Introduction: Neo4j clustering architecture_ . 
  _Bevezetés: Neo4j fürtözési architektúra._

https://neo4j.com/docs/operations-manual/current/clustering/introduction/ 

- [16] Neo4j. _The impact of indexes on query performance_ . 
  _Az indexek hatása a lekérdezési teljesítményre._

https://neo4j.com/docs/cypher-manual/current/indexes/search-performance-indexes/using-indexes/ 

- [17] Neo4j. _Cypher Shell_ . 
  _Cypher Shell parancssori felület._

https://neo4j.com/docs/operations-manual/current/cypher-shell/ 

- [18] Neo4j. _Database transactions_ ; _Concurrent data access_ . 
  _Adatbázis-tranzakciók_; _Egyidejű adathozzáférés._

https://neo4j.com/docs/operations-manual/current/database-internals/ 

https://neo4j.com/docs/operations-manual/current/database-internals/concurrent-data-access/ 

- [19] Apache Cassandra. _CQL: Data Definition_ . 
  _CQL: Adatdefiníció (DDL)._

https://cassandra.apache.org/doc/stable/cassandra/developing/cql/ddl.html 

- [20] Apache Cassandra. _CQL: Data Manipulation_ . 
  _CQL: Adatmanipuláció (DML)._

https://cassandra.apache.org/doc/stable/cassandra/developing/cql/dml.html 

- [21] Apache Cassandra. _Architecture: Dynamo_ . 
  _Architektúra: Dynamo modell._

https://cassandra.apache.org/doc/stable/cassandra/architecture/dynamo.html 

- [22] Apache Cassandra. _Logical data modeling_ . 
  _Logikai adatmodellezés._

https://cassandra.apache.org/doc/stable/cassandra/developing/data-modeling/data-modeling_logical. html 

- [23] Apache Cassandra. _Architecture: Guarantees_ . 
  _Architektúra: Garanciák._

https://cassandra.apache.org/doc/stable/cassandra/architecture/guarantees.html 

- [24] Apache Cassandra. _cqlsh: the CQL shell_ ; _nodetool getendpoints_ . 
  _cqlsh: a CQL shell_; _nodetool getendpoints parancs._

https://cassandra.apache.org/doc/stable/cassandra/managing/tools/cqlsh.html 

https://cassandra.apache.org/doc/stable/cassandra/managing/tools/nodetool/getendpoints.html 

- [25] Redis. _Licences: Redis Open Source and commercial products_ . 
  _Licencek: Redis nyílt forráskód és kereskedelmi termékek._

https://redis.io/legal/licenses/ 

- [26] Redis. _Official release notes: Redis 8.10.2, 17 September 2026_ . 
  _Hivatalos kiadási megjegyzések: Redis 8.10.2, 2026. szeptember 17._

https://github.com/redis/redis/releases/tag/8.10.2 

- [27] Apache CouchDB. _Downloads and releases_ ; _Licence_ . 
  _Letöltések és kiadások_; _Licenc._

https://couchdb.apache.org/ 

https://github.com/apache/couchdb/blob/main/LICENSE 

- [28] Apache Cassandra. _Download: latest stable release_ ; _Licence_ . 
  _Letöltés: legújabb stabil kiadás_; _Licenc._

https://cassandra.apache.org/_/download.html https://github.com/apache/cassandra/blob/trunk/LICENSE.txt 

NMI_PI130G3 

19 / 20 

NoSQL group <u>project</u> 
NoSQL csoportos <u>projekt</u>

Big Data Management and Processing 
Big Data Kezelés és Feldolgozás

- [29] Neo4j. _Pricing and Community Edition_ ; _Legal terms_ . 
  _Árképzés és Community Edition_; _Jogi feltételek._

https://neo4j.com/pricing/ 

https://neo4j.com/legal-terms/ 

- [30] Docker. _Docker Desktop licence agreement_ . 
  _Docker Desktop licencszerződés._

https://docs.docker.com/subscription-billing/desktop-license/ 

- [31] Neo4j. _Software Evaluation Agreement_ , terms checked 27 September 2026. 
  _Szoftverértékelési Szerződés (Software Evaluation Agreement)_, feltételek ellenőrizve: 2026. szeptember 27.

https://neo4j.com/legal-terms/software-eval-agreement/ 

- [32] Neo4j. _Linux executable (.tar): prerequisites and evaluation activation_ . 
  _Linux futtatható állomány (.tar): előfeltételek és az értékelési verzió aktiválása._

https://neo4j.com/docs/operations-manual/current/installation/linux/tarball/ 

- [33] Neo4j. _Desktop licence: named-user restrictions_ . 
  _Desktop licenc: megnevezett felhasználóra vonatkozó korlátozások._

https://neo4j.com/legal-terms/desktop-license/ 

- [34] Neo4j. _Deploying a Neo4j cluster in a Docker container_ . 
  _Neo4j fürt üzembe helyezése Docker konténerben._

https://neo4j.com/docs/operations-manual/current/tutorial/tutorial-clustering-docker/ 

- [35] Neo4j. _Create constraints: Community and Enterprise capabilities_ . 
  _Kényszerek (constraints) létrehozása: Community és Enterprise képességek._

https://neo4j.com/docs/cypher-manual/current/schema/constraints/create-constraints/ 

- [36] Apache Cassandra 5.0.9. _Installing Cassandra_ . 
  _A Cassandra telepítése._

https://cassandra.apache.org/doc/stable/cassandra/installing/installing.html 

- [37] Apache Cassandra 5.0. _Hints_ ; _Repair_ . 
  _Célzott kézbesítés (hints)_; _Javítás (repair)._

https://cassandra.apache.org/doc/stable/cassandra/managing/operating/hints.html https://cassandra.apache.org/doc/stable/cassandra/managing/operating/repair.html 

- [38] Apache CouchDB. _Replicator Database: creating and cancelling jobs_ . 
  _Replicator adatbázis: feladatok létrehozása és törlése._

https://docs.couchdb.org/en/stable/replication/replicator.html 

- [39] Apache CouchDB. _Document API: deletion, revisions, and tombstones_ . 
  _Dokumentum API: törlés, revíziók és tombstone (sírkő) rekordok._

https://docs.couchdb.org/en/stable/api/document/common.html 

- [40] Apache Cassandra. _Read repair_ . 
  _Olvasás közbeni javítás (read repair)._

https://cassandra.apache.org/doc/stable/cassandra/managing/operating/read_repair.html 

Documentation and software-access conditions checked on 27 September 2026. Use documentation matching your selected release. The Cassandra references use the stable manual, whose 5.0 version should be selected for this assignment. 

A dokumentációs és szoftverhozzáférési feltételek 2026. szeptember 27-én lettek ellenőrizve. A kiválasztott kiadásnak megfelelő dokumentációt használjátok. A Cassandra hivatkozások a stabil kézikönyvet használják, amelynek 5.0-s verzióját kell kiválasztani ehhez a feladathoz.

NMI_PI130G3 

20 / 20 

