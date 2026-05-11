# Engineering DNA: Architecture & Dependency Injection

## 1. Engineering Mindset
The developer operates with a **"Structural Predictability"** mindset. They prioritize a codebase where the "location of logic" is deterministic and non-negotiable, even at the cost of significant boilerplate. 

- **Problem Solving via Layering:** Every business requirement is decomposed into a three-tier execution chain: *Intent (UseCase) -> Strategy (Repository) -> Implementation (DAO/Service)*.
- **Conscious Trade-off:** They exchange "Conciseness" for "Auditability." By creating a unique class for every single action, they ensure that changing one feature never unintentionally breaks another, providing a high degree of isolation.
- **Deliberate Avoidance:** They avoid "Smart UI" and "Fat Repositories." Repositories are kept stateless regarding the UI, acting only as data flow pipes. They also avoid deep inheritance, preferring flat, composition-based dependency trees.

## 2. Decision Patterns
- **The "Single-Entry" Pattern:** UseCases always expose a single public method (effectively the Command pattern). This reveals a mindset that views the application as a collection of discrete, triggerable actions.
- **Lazy initialization by Default:** Everything in the dependency tree is a `LazySingleton`. This suggests a focus on memory efficiency and a "pay-for-what-you-use" startup philosophy.
- **Naming as Documentation:** Naming follows a strict `[Feature][Action]UseCase` and `[Feature]Repository` convention. This eliminates the need for external documentation as the project structure itself serves as the map.

## 3. Dependency & Communication Rules
- **Top-Down Dependency:** Layers only know about the layer directly beneath them. UseCases depend on Repositories; Repositories depend on DAOs/Services.
- **Service Locator as the "Glue":** The developer uses a centralized service locator (GetIt) to decouple implementation from usage. However, dependencies are strictly injected via constructors at the UseCase level, ensuring they remain testable.
- **Cross-Platform Branching:** The Repository layer is the designated "Decision Maker" for platform-specific behavior (e.g., bypassing local cache on Web). This keeps the domain logic (UseCases) and UI pure and platform-agnostic.

## 4. Implicit Rules
- **No Direct DAO Access:** The UI or UseCases must never talk to a DAO directly. Data persistence is a secret kept by the Repository.
- **Fail-Safe Returns:** Repository methods often wrap operations in `try-catch` blocks, returning primitives (like `bool`) or nullable types. This indicates a "Graceful Degradation" philosophy where the app should continue running even if a specific data sync fails.
- **Flat Registration:** All dependencies must be registered in a single, global initialization function, organized by layer (Repositories first, then DAOs, then UseCases).

## 5. Replication Guide

If starting a new feature from scratch, follow these exact mental steps:

### Step A: Define the Data Interface (Implementation)
Create the low-level contracts for how data is fetched or stored.
- *Pseudocode:* `CLASS FeatureDAO { METHOD save(); METHOD fetch(); }`

### Step B: Orchestrate the Flow (Repository)
Create a repository that decides when to use the Network vs. the Local Database.
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

### Step C: Encapsulate the Intent (UseCase)
Wrap each repository method in a dedicated UseCase class.
- *Pseudocode:*
  ```
  CLASS PerformActionUseCase {
      CONSTRUCTOR(FeatureRepository)
      METHOD execute() => FeatureRepository.performAction()
  }
  ```

### Step D: Register the DNA (DI)
Add the new components to the global locator in the specific order of their dependency hierarchy.
- *Pseudocode:*
  ```
  REGISTER_LAZY_SINGLETON(FeatureRepository())
  REGISTER_LAZY_SINGLETON(PerformActionUseCase(RESOLVE(FeatureRepository)))
  ```
