# Engineering DNA: State Management (BLoC/Cubit Pattern)

## 1. Engineering Mindset
The developer views the UI Controller (Cubit) as a **"Feature Orchestrator"** rather than a simple data stream. They prioritize "The Full Picture" over "Granular Isolation."

- **Problem Solving via Consolidation:** Instead of breaking a complex screen (like Home) into ten small Cubits, they prefer one "Omni-Cubit" that holds the entire screen's context. This solves the problem of cross-feature state synchronization at the cost of class size.
- **Trade-off (Imperative vs. Reactive):** They deliberately favor **Imperative Async Chains** (`.then()`, `.catchError()`) over `try/catch` or `async/await` patterns. This is a **non-negotiable project standard**, not a style preference. Every Future in the codebase must follow this pattern.
- **Deliberate Avoidance:** They avoid complex BLoC Event classes. By using Cubits, they treat UI interactions as direct method calls, reducing the mental mapping required between the UI and the controller.

## 2. Decision Patterns
- **The "Aggregate State" Pattern:** States are almost always "Large Objects" built with Freezed. Instead of switching between `LoadingState` and `SuccessState`, they maintain a single state containing multiple **Status Enums** (e.g., `requestStatus`, `searchStatus`).
- **Lazy Dependency Resolution:** Dependencies (Repositories) are resolved via the Service Locator directly within the class body as `final` fields. The Cubit is the sole consumer of Repositories.
- **Immediate vs. Deferred Updates:**
  - **Immediate:** Local UI state changes (e.g., toggles, visibility) are emitted instantly without a loading status.
  - **Deferred:** Data-fetching actions always follow a `Submitting -> Success/Error` lifecycle.

## 3. Dependency & Communication Rules
- **Cubit is the Logic Boundary:** The Cubit is the absolute owner of all screen logic. **No business logic, API calls, or database operations are permitted inside UI files.** The UI's only job is to call Cubit methods and render state.
- **No Logic in UI:** UI files must never contain:
  - Direct Repository or DAO calls
  - `Future` chains or async operations
  - Conditional business logic (e.g., `if (user.isPremium) doX()`)
  - Any computation beyond simple display formatting
- **BlocListener for Side Effects:** Navigation, Snackbars, Dialogs, and any one-time reaction to a state change must be handled inside a `BlocListener` or `MultiBlocListener` in the UI. The Cubit emits a status; the UI listens and reacts. The Cubit never navigates directly.
- **State Ownership:** The Cubit owns the screen lifecycle. It is the only entity allowed to talk to Repositories AND directly to Local Storage (Preferences) when needed.

## 4. Implicit Rules
- **`.then().catchError()` is the Law:** Every single `Future` in the codebase must use the `.then().catchError()` chain pattern. `try/catch` blocks and bare `async/await` are not used for Future handling. This is consistent and non-negotiable across the entire project.
  ```dart
  // ✅ Correct
  repository.fetchData()
    .then((result) => emit(state.copyWith(status: Status.success, data: result)))
    .catchError((e) => emit(state.copyWith(status: Status.error, message: errorHandler(e))));

  // ❌ Wrong
  try {
    final result = await repository.fetchData();
    emit(state.copyWith(status: Status.success, data: result));
  } catch (e) {
    emit(state.copyWith(status: Status.error));
  }
  ```
- **`if/else` is the Only Pattern in BlocListener:** Inside `BlocListener` and `MultiBlocListener`, state is always checked using direct field comparison (`state.status == MyStatus.success`) combined with plain `if/else` blocks. Freezed's `.when()`, `.maybeWhen()`, `.map()`, and `.maybeMap()` are **strictly forbidden** inside listeners. This keeps listener code flat, readable, and consistent.
  ```dart
  // ✅ Correct
  BlocListener<FeatureCubit, FeatureState>(
    listenWhen: (prev, curr) => prev.requestStatus != curr.requestStatus,
    listener: (context, state) {
      if (state.requestStatus == RequestStatus.success) {
        context.pop();
      } else if (state.requestStatus == RequestStatus.error) {
        axinoSnackBar(context: context, message: state.errorMessage);
      }
    },
  )

  // ❌ Wrong
  listener: (context, state) {
    state.requestStatus.maybeWhen(
      success: () => context.pop(),
      error: () => axinoSnackBar(...),
      orElse: () {},
    );
  }
  ```
- **Status-Driven UI:** Every asynchronous action must have a corresponding status field in the state. The UI must never "guess" if a process is running; the state must explicitly declare `Submitting`.
- **Pre-Initialization:** Heavy data fetching is triggered via an `init()` method called immediately after the Cubit is created (typically via `addPostFrameCallback` or `BlocProvider`'s `create`).
- **Private Helper Methods in Cubit:** When a Cubit method grows large, it is broken into private helper methods (`_loadWalletInfo`, `_handleError`) within the same Cubit file. Logic is never moved to the UI to compensate for Cubit complexity.

## 5. Replication Guide

To implement a new feature (e.g., "Settings Dashboard") matching this DNA, follow these steps:

### Step 1: Build the "Omni-State"
Create a single Freezed class. It must contain:
- One `AsyncStatus` enum for every major server interaction.
- Primitive types for simple UI toggles.
- Models for the actual data.
- *Abstract Logic:* `CLASS FeatureState(status: Enum, data: Model, toggle: Bool)`

### Step 2: Resolve Global Context
Inside the Cubit class body, resolve every Repository the screen might need as final fields via the service locator.
- *Abstract Logic:* `FINAL repo = sl<FeatureRepository>()`

### Step 3: Implement Action Chains
When performing an action, always use the `.then().catchError()` pattern. Never use try/catch.
- *Abstract Logic:*
  ```
  FUNCTION performAction() {
    EMIT(state.copy(status: SUBMITTING))
    repo.fetchData()
      .then((data) => EMIT(state.copy(status: SUCCESS, data: data)))
      .catchError((e) => EMIT(state.copy(status: ERROR, message: errorHandler(e))))
  }
  ```

### Step 4: Aggregate Initialization
If the screen needs data from multiple sources, use `Future.wait` to fetch them in parallel and emit a single cohesive state update when all are ready.

### Step 5: BlocListener for Side Effects
In the UI, wrap the screen in a `MultiBlocListener`. Each listener reacts to a specific status field. Navigation and Snackbars live here — not in the Cubit, not inside `BlocBuilder`.
- *Abstract Logic:*
  ```dart
  MultiBlocListener(
    listeners: [
      BlocListener<FeatureCubit, FeatureState>(
        listenWhen: (prev, curr) => prev.requestStatus != curr.requestStatus,
        listener: (context, state) {
          if (state.requestStatus == RequestStatus.success) {
            context.pop();
          } else if (state.requestStatus == RequestStatus.error) {
            axinoSnackBar(context: context, message: state.errorMessage);
          }
        },
      ),
    ],
    child: ...
  )
  ```