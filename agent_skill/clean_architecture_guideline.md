# Engineering DNA: Clean Architecture & Synchronization

## 1. Engineering Mindset
The developer views architecture as a **"Synchronization Engine"** rather than just a way to organize code. The primary problem being solved is the "Offline-First vs. Web-Only" dichotomy.

- **The "Branching Repository" Strategy:** Instead of creating separate implementations for different platforms, the developer uses the Repository as a decision-making hub. It evaluates the environment (Web vs. Mobile) and the network state internally to determine the data path.
- **Trade-off: Complexity in the Center:** They accept higher complexity in the Repository (e.g., manual sync status management) to keep the UI and Cubits "dumb" and platform-agnostic.
- **Deliberate Avoidance:** They avoid "Streaming" data layers (like persistent streams from the DB to UI). Instead, they favor **Snapshot-based Requests**. Data is fetched, processed into a bundle, and emitted as a static state. They also avoid an intermediate UseCase layer — the Cubit communicates with the Repository directly.

## 2. Decision Patterns
- **The "Data Bundle" Return:** Repositories often return a `Map` or a complex object containing not just the raw data, but also calculated metadata required for the UI (e.g., `chartData`, `max`, `min`). This reveals a mindset where the Repository understands the *visual context* of the data it provides.
- **Grouped Repository Methods:** All actions related to a single domain entity live inside one concrete Repository class (e.g., `get`, `add`, `update`, `delete`). The developer views a feature as a "Collection of Capabilities" co-located inside the Repository, rather than spread across isolated UseCase classes.
- **Service Locator as "Field-Level" Injection:** The Repository is resolved via `sl<FeatureRepository>()` as a final field in the Cubit. This indicates a preference for "Component-as-a-Service" where parts of the system are available globally but consumed locally.

## 3. Dependency & Communication Rules
- **Direct Cubit → Repository Communication:** The Cubit is allowed — and expected — to call the Repository directly. There is no UseCase layer. The Repository is the single boundary between the Cubit and data concerns.
- **No Abstract Repository:** There is no abstract `IFeatureRepository` or interface. Only one concrete `FeatureRepository` class exists per feature. This is an explicit architectural decision to reduce boilerplate.
- **Smart DAOs:** The DAO (Data Access Object) is not just a raw query layer. It is responsible for mapping DTOs to Entities and performing aggregate calculations (e.g., `max()`, `min()`, `countUnSync()`).
- **State Ownership:** The Cubit owns the "Process Status" (`Submitting`, `Success`, `Error`), but the Repository owns the "Sync Status" (`update`, `delete`, `synced`). These two lifecycles are separate but coordinated.

## 4. Implicit Rules
- **The Analytics Anchor:** Every Cubit method that modifies data (Add/Update/Delete) must contain a call to an analytics event tracking system. In this DNA, an action is only "done" if it is logged.
- **Manual Mapping Ritual:** There is a heavy reliance on manual `toDto()` and `fromDto()` methods. The developer trusts explicit conversion logic over automated reflection or code-generated mappers for domain entities.
- **Web vs. Native Divergence:** If `kIsWeb` is true, local persistence (DAOs) is bypassed entirely in favor of direct service calls. This branching lives exclusively inside the Repository.

## 5. Replication Guide

To implement a new feature (e.g., "Water Intake") in this style, follow these steps:

### Step 1: The Domain Secret (DAO)
Create a DAO that handles local storage and tracks the "Sync Health" of every record.
- *Abstract Logic:* `CLASS FeatureDAO { METHOD getUnsynced(); METHOD markAsDeleted(); }`

### Step 2: The Decision Maker (Repository)
Implement a **single concrete** Repository class that contains all feature actions and branches logic based on platform. No abstract interface needed.
- *Abstract Logic:*
  ```
  CLASS FeatureRepository {
    METHOD fetchData() {
        IF PLATFORM_IS_WEB:
            RETURN Service.fetch()
        ELSE:
            Data = DAO.get()
            RETURN {"items": Data, "metadata": calculateStats(Data)}
    }
    METHOD addItem(item) { ... }
    METHOD deleteItem(id) { ... }
  }
  ```

### Step 3: Register in DI
Register the DAO and then the Repository as lazy singletons. No UseCase registration.
- *Abstract Logic:*
  ```
  REGISTER_LAZY_SINGLETON(FeatureDAO())
  REGISTER_LAZY_SINGLETON(FeatureRepository(RESOLVE(FeatureDAO), RESOLVE(FeatureService)))
  ```

### Step 4: The Orchestrator (Cubit)
Inject the Repository as a single final field. Manage independent statuses for every asynchronous request in the state. Call Repository methods directly.
- *Abstract Logic:*
  ```
  CLASS FeatureCubit {
    FINAL repo = sl<FeatureRepository>()
    METHOD load() {
        EMIT(status: SUBMITTING)
        repo.fetchData().THEN(emit SUCCESS).CATCH(emit ERROR)
    }
    METHOD add(item) {
        EMIT(status: SUBMITTING)
        repo.addItem(item).THEN(emit SUCCESS).CATCH(emit ERROR)
        ANALYTICS.log("feature_add")
    }
  }
  ```

### Step 5: The UI Entry
Initialize the Cubit in the `BlocProvider` within the screen file. Use `MultiBlocListener` to react to specific status changes (e.g., popping the screen after a successful "Edit").