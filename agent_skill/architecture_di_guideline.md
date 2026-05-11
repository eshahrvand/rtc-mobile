# Engineering DNA: Architecture & Dependency Injection

## 1. Engineering Mindset
The developer operates with a **"Structural Predictability"** mindset. They prioritize a codebase where the "location of logic" is deterministic and non-negotiable, even at the cost of significant boilerplate.

- **Problem Solving via Layering:** Every business requirement is decomposed into a two-tier execution chain: *Strategy (Repository) -> Implementation (DAO/Service)*. The Cubit is the consumer at the top; it calls the Repository directly. There is no intermediate UseCase layer.
- **Conscious Trade-off:** They exchange "Conciseness" for "Auditability." By organizing all actions as dedicated methods inside a single concrete Repository class, they ensure feature logic is co-located, easy to trace, and isolated from other features.
- **Deliberate Avoidance:** They avoid "Smart UI," "Fat Repositories," and an unnecessary UseCase abstraction layer. Repositories are **concrete classes** — not abstract interfaces with separate implementations. They also avoid deep inheritance, preferring flat, composition-based dependency trees.

## 2. Decision Patterns
- **The "Concrete Repository" Pattern:** A Repository is a single, concrete class registered in GetIt. There is no abstract interface to implement. This eliminates the boilerplate of maintaining parallel abstract + implementation files while keeping the architecture structured and predictable.
- **Lazy Initialization by Default:** Everything in the dependency tree is a `LazySingleton`. This suggests a focus on memory efficiency and a "pay-for-what-you-use" startup philosophy.
- **Naming as Documentation:** Naming follows a strict `[Feature]Repository` convention for repositories and `[Feature]Cubit` for state managers. This eliminates the need for external documentation as the project structure itself serves as the map.

## 3. Dependency & Communication Rules
- **Top-Down Dependency:** Layers only know about the layer directly beneath them. Cubits depend on Repositories; Repositories depend on DAOs/Services.
- **No UseCase Layer:** There is no UseCase layer. The Cubit is the orchestrator and calls Repository methods directly. Adding a UseCase as a pass-through is considered unnecessary indirection and is explicitly avoided.
- **No Abstract Repository:** Repositories are never defined as abstract classes or interfaces. A single concrete `[Feature]Repository` class is created and registered directly. This is a deliberate trade-off of testability-via-interface for simplicity and speed of development.
- **Service Locator as the "Glue":** The developer uses a centralized service locator (GetIt) to decouple implementation from usage. Repositories are injected into Cubits via the service locator (`sl<FeatureRepository>()`).
- **Cross-Platform Branching:** The Repository layer is the designated "Decision Maker" for platform-specific behavior (e.g., bypassing local cache on Web). This keeps the UI and Cubit layer pure and platform-agnostic.

## 4. Implicit Rules
- **No Direct DAO Access from Cubit:** The UI or Cubits must never talk to a DAO directly. Data persistence is a secret kept by the Repository.
- **Fail-Safe Returns:** Repository methods often wrap operations in `try-catch` blocks, returning primitives (like `bool`) or nullable types. This indicates a "Graceful Degradation" philosophy where the app should continue running even if a specific data sync fails.
- **Flat Registration:** All dependencies must be registered in a single, global initialization function, organized by layer (DAOs first, then Repositories). There is no UseCase registration step.

## 5. Replication Guide

If starting a new feature from scratch, follow these exact mental steps:

### Step A: Define the Data Interface (Implementation)
Create the low-level contracts for how data is fetched or stored.
- *Pseudocode:* `CLASS FeatureDAO { METHOD save(); METHOD fetch(); }`

### Step B: Orchestrate the Flow (Repository)
Create a **single concrete** repository class that decides when to use the Network vs. the Local Database. No abstract class or interface is needed.
- *Pseudocode:*
  ```
  CLASS FeatureRepository {
    METHOD performAction() {
        IF online:
            result = RemoteService.fetch()
            LocalDAO.persist(result)
        RETURN LocalDAO.read()
    }
  }
  ```

### Step C: Register the DNA (DI)
Add the new components to the global locator. Register DAOs first, then Repositories. No UseCase registration exists.
- *Pseudocode:*
  ```
  REGISTER_LAZY_SINGLETON(FeatureDAO())
  REGISTER_LAZY_SINGLETON(FeatureRepository(RESOLVE(FeatureDAO)))
  ```

### Step D: Consume in Cubit
Resolve the Repository directly in the Cubit. No UseCase intermediary.
- *Pseudocode:*
  ```
  CLASS FeatureCubit {
    FINAL repo = sl<FeatureRepository>()
    METHOD load() {
        EMIT(status: LOADING)
        repo.performAction().THEN(emit SUCCESS).CATCH(emit ERROR)
    }
  }
  ```