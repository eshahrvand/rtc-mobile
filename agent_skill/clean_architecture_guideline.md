# Engineering DNA: Clean Architecture & Synchronization

## 1. Engineering Mindset
The developer views architecture as a **"Synchronization Engine"** rather than just a way to organize code. The primary problem being solved is the "Offline-First vs. Web-Only" dichotomy.

- **The "Branching Repository" Strategy:** Instead of creating separate implementations for different platforms, the developer uses the Repository as a decision-making hub. It evaluates the environment (Web vs. Mobile) and the network state internally to determine the data path.
- **Trade-off: Complexity in the Center:** They accept higher complexity in the Repository (e.g., manual sync status management) to keep the UI and UseCases "dumb" and platform-agnostic.
- **Deliberate Avoidance:** They avoid "Streaming" data layers (like persistent streams from the DB to UI). Instead, they favor **Snapshot-based Requests**. Data is fetched, processed into a bundle, and emitted as a static state.

## 2. Decision Patterns
- **The "Data Bundle" Return:** Repositories often return a `Map` or a complex object containing not just the raw data, but also calculated metadata required for the UI (e.g., `chartData`, `max`, `min`). This reveals a mindset where the Repository understands the *visual context* of the data it provides.
- **Grouped Command UseCases:** Multiple UseCases related to a single domain entity are housed in a single file. This suggests they view a feature as a "Collection of Capabilities" rather than isolated, disconnected actions.
- **Service Locator as "Field-Level" Injection:** UseCases are resolved via `sl<UseCase>()` as final fields in the Cubit. This indicates a preference for "Component-as-a-Service" where parts of the system are available globally but consumed locally.

## 3. Dependency & Communication Rules
- **The Domain API (UseCases):** The Cubit is strictly forbidden from talking to a Repository. It must use a UseCase. Even if the UseCase is a 1-to-1 pass-through, the boundary is never skipped.
- **Smart DAOs:** The DAO (Data Access Object) is not just a raw query layer. It is responsible for mapping DTOs to Entities and performing aggregate calculations (e.g., `max()`, `min()`, `countUnSync()`).
- **State Ownership:** The Cubit owns the "Process Status" (`Submitting`, `Success`, `Error`), but the Repository owns the "Sync Status" (`update`, `delete`, `synced`). These two lifecycles are separate but coordinated.

## 4. Implicit Rules
- **The Analytics Anchor:** Every Cubit method that modifies data (Add/Update/Delete) must contain a call to an analytics event tracking system. In this DNA, an action is only "done" if it is logged.
- **Manual Mapping Ritual:** There is a heavy reliance on manual `toDto()` and `fromDto()` methods. The developer trusts explicit conversion logic over automated reflection or code-generated mappers for domain entities.
- **Web vs. Native Divergence:** If `kIsWeb` is true, local persistence (DAOs) is bypassed entirely in favor of direct service calls.

## 5. Replication Guide

To implement a new feature (e.g., "Water Intake") in this style, follow these steps:

### Step 1: The Domain Secret (DAO)
Create a DAO that handles local storage but also tracks the "Sync Health" of every record.
- *Abstract Logic:* `CLASS FeatureDAO { METHOD getUnsynced(); METHOD markAsDeleted(); }`

### Step 2: The Decision Maker (Repository)
Implement a Repository that branches logic based on the platform.
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
  }
  ```

### Step 3: The Capability Collection (UseCases)
Create one file containing a class for every action.
- *Abstract Logic:* `CLASS GetDataUseCase; CLASS AddDataUseCase; CLASS DeleteDataUseCase;`

### Step 4: The Orchestrator (Cubit)
Inject the UseCases as fields. Manage independent statuses for every asynchronous request in the state.
- *Abstract Logic:* 
  ```
  CLASS FeatureCubit {
    FINAL getAction = SL.get<GetDataUseCase>()
    METHOD load() {
        EMIT(status: SUBMITTING)
        getAction().THEN(emit SUCCESS).CATCH(emit ERROR)
    }
  }
  ```

### Step 5: The UI Entry
Initialize the Cubit in the `BlocProvider` within the screen file. Use `MultiBlocListener` to react to specific status changes (e.g., popping the screen after a successful "Edit").
