# Engineering DNA: Local Data Layer

## 1. Engineering Mindset
The developer views the local database as a **"Disposable High-Performance Cache"** rather than a permanent independent storage system.

- **Problem Solving via Total Reset:** Instead of complex migration scripts, they favor a "Wipe and Re-sync" strategy. If the database version shifts, the local file is destroyed. This reveals a mindset where the Cloud is the absolute source of truth, and local storage is merely a transient projection of that truth.
- **Trade-off (Global Availability over Encapsulation):** They deliberately use a static singleton pattern for database access. They trade the testability of dependency injection for the immediate availability of the database instance across any layer of the app.
- **Deliberate Avoidance of Cascades:** They avoid native database foreign key constraints and cascading deletes. Instead, they centralize the responsibility for relational integrity within the Data Access Object (DAO) itself.

## 2. Decision Patterns
- **The "Pinning ID" Pattern:** When updating records from external sources, the developer manually bridges the "Domain Identity" and the "Internal Database Identity." They look up existing records by a business ID, then manually re-assign the internal primary key to the incoming object to ensure an "Upsert" behavior without duplicates.
- **Relational Cleanup Ritual:** Every deletion event is treated as a manual cleanup operation. If a primary record is removed, the developer explicitly queries and deletes all associated "child" records within the same transaction.
- **String-Based Primary Logic:** They prefer searching by UUID/String identifiers over auto-incremented integers, suggesting the data architecture is designed for a distributed system where IDs are generated outside the local database.

## 3. Dependency & Communication Rules
- **Direct Global Access:** DAOs communicate with the database via a public static instance. There is no middle-man or repository-level injection for the database provider.
- **DAOs as Mapping Stations:** The DAO is the designated layer where "Network Objects" (DTOs) are transformed into "Local Entities." The DAO understands both the shape of the data on the wire and the shape of the data on the disk.
- **DAO is a Private Detail of the Repository:** DAOs are never called from the Cubit directly. The Repository is the only consumer of DAO methods. The Cubit has no awareness that a DAO exists.
- **Web-Divergent Persistence:** The developer explicitly branches the initialization logic. On the web, the persistence layer is often reduced to a skeleton, indicating a "Live-Only" mindset for browser-based users, whereas mobile users get the full "Offline-First" treatment. This branching is handled inside the Repository, not the Cubit.

## 4. Implicit Rules
- **The Sync-First Transaction:** Data modification is rarely a simple "Add." It is almost always a "Sync Payload" processing event that handles Create, Update, and Delete operations in a single atomic transaction.
- **Key-Value Mirroring:** For simple flags and session data, the developer uses a strictly static wrapper around Preferences. Every key is a global constant, ensuring that the "Memory" of the app is as predictable as the "Database."
- **Search-Side Filtering:** For complex queries (like multi-word fuzzy search), the developer prefers to pull data into memory and filter using language-native logic rather than relying solely on the database's query engine.

## 5. Replication Guide

To implement a new data entity (e.g., "Sleep Metrics") in this style, follow these steps:

### Step 1: The Domain Entity
Define the local model. Ensure it has a method to convert from its network counterpart and preserve its internal database ID during synchronization.

### Step 2: Relational Awareness
In the DAO, identify all "Sibling" or "Child" entities. If the primary entity is modified or deleted, write explicit logic to find and purge those related records first.
- *Abstract Logic:* `ON DELETE(Parent): QUERY Children WHERE ParentID == Parent.ID; DELETE(Children); DELETE(Parent);`

### Step 3: The Atomic Sync Method
Implement a single method in the DAO that accepts a "Sync Bundle." This method must:
1. Start a single write transaction.
2. Iterate through "Created" and "Updated" lists, performing the "Pinning ID" lookup for each.
3. Iterate through the "Deleted" list, performing the "Relational Cleanup."

### Step 4: The Static Accessor
Expose the DAO methods as a stateless class. Use the global static database instance for all operations. Do not require the database to be passed in as a parameter.

### Step 5: Global Schema Registration
Add the new schema to the centralized initialization list. Ensure that any version increment in the global configuration triggers the automatic file deletion logic to prevent schema mismatch crashes.

### Step 6: Wire into Repository
Register the DAO as a `LazySingleton` in GetIt, then inject it into the corresponding `FeatureRepository`. The Repository is the sole consumer of this DAO — no other layer should reference it directly.
- *Pseudocode:*
  ```
  REGISTER_LAZY_SINGLETON(FeatureDAO())
  REGISTER_LAZY_SINGLETON(FeatureRepository(RESOLVE(FeatureDAO)))
  ```