# Engineering DNA: State Management (BLoC/Cubit Pattern)

## 1. Engineering Mindset
The developer views the UI Controller (Cubit) as a **"Feature Orchestrator"** rather than a simple data stream. They prioritize "The Full Picture" over "Granular Isolation."

- **Problem Solving via Consolidation:** Instead of breaking a complex screen (like Home) into ten small Cubits, they prefer one "Omni-Cubit" that holds the entire screen's context. This solves the problem of cross-feature state synchronization at the cost of class size.
- **Trade-off (Imperative vs. Reactive):** They deliberately favor **Imperative Async Chains** (`.then()`, `.catchError()`) over the more standard `async/await` syntax. This reveals a mindset that treats asynchronous operations as a series of distinct "Lifecycle Events" rather than a linear execution of code.
- **Deliberate Avoidance:** They avoid complex BLoC Event classes. By using Cubits, they treat UI interactions as direct method calls, reducing the mental mapping required between the UI and the controller.

## 2. Decision Patterns
- **The "Aggregate State" Pattern:** States are almost always "Large Objects" built with Freezed. Instead of switching between `LoadingState` and `SuccessState`, they maintain a single state containing multiple **Status Enums** (e.g., `requestStatus`, `searchStatus`).
- **Lazy Dependency Resolution:** Dependencies (UseCases) are resolved via the Service Locator directly within the class body. This suggests they view the Cubit as a consumer of the global environment rather than a strictly isolated unit.
- **Immediate vs. Deferred Updates:** 
    - **Immediate:** Local UI state changes (e.g., toggles) are emitted instantly.
    - **Deferred:** Data-fetching actions always follow a `Submitting -> Success/Error` lifecycle.

## 3. Dependency & Communication Rules
- **State Ownership:** The Cubit is the absolute owner of the screen logic. It is the only entity allowed to talk to UseCases AND directly to Local Storage (Preferences).
- **Boundary Crossing:** The Cubit acts as a "Platform Translator." It is the layer where global platform checks (e.g., `kIsWeb`, `Platform.isAndroid`) are converted into business-friendly state flags.
- **State Birth:** Every state starts with a heavy set of `@Default` values, ensuring the UI never encounters a null-pointer or an undefined UI element during the first frame.

## 4. Implicit Rules
- **The Chain of Responsibility:** Long, nested `.then()` chains are the standard for multi-step initialization (e.g., Check Store -> Get Token -> Get Profile -> Sync). Breaking this into separate methods is only done if the logic is reusable.
- **Status-Driven UI:** Every asynchronous action must have a corresponding `AsyncStatus` field in the state. The UI must never "guess" if a process is running; the state must explicitly say `Submitting`.
- **Pre-Initialization:** Heavy data fetching is often triggered by an `init()` style method called immediately after the Cubit is born or during the first frame.

## 5. Replication Guide

To implement a new feature (e.g., "Settings Dashboard") matching this DNA, follow these steps:

### Step 1: Build the "Omni-State"
Create a single Freezed class. It must contain:
- One `AsyncStatus` enum for every major server interaction.
- Primitive types for simple UI toggles.
- Models for the actual data.
- *Abstract Logic:* `CLASS FeatureState(status: Enum, data: Model, toggle: Bool)`

### Step 2: Resolve Global Context
Inside the Cubit class body, use the service locator to grab every UseCase the screen might ever need.
- *Abstract Logic:* `FINAL fetchAction = LOCATOR.get<FetchUseCase>()`

### Step 3: Implement Action Chains
When performing an action, use the `.then()` pattern to transition the state.
- *Abstract Logic:*
  ```
  FUNCTION performAction() {
    EMIT(state.copy(status: SUBMITTING))
    UseCase.call()
      .then((data) => EMIT(state.copy(status: SUCCESS, data: data)))
      .catchError((err) => EMIT(state.copy(status: ERROR)))
  }
  ```

### Step 4: Aggregate Initialization
If the screen needs data from five sources, use a "Gathering" pattern (like `Future.wait`) to fetch them all and emit a single cohesive state update when the essential parts are ready.

### Step 5: Platform Awareness
If a feature behaves differently on Web vs Mobile, handle that logic directly inside the Cubit method before calling the UseCase or updating the state.
