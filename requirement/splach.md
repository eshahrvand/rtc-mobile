# Feature Spec: Splash Screen

## 1. Overview
The Splash screen is the **root entry point** of the application.
It is the first screen every user sees when the app launches.

---

## 2. UI Specification

- Background: solid white
- Content: the project logo (`rtc_logo`) centered both horizontally and vertically
- The logo asset is located in the project's `assets/` folder
- No other UI elements are present on this screen

---

## 3. User Flow

```
App launches
    └── Splash screen appears (white + logo)
            └── 1 second passes
                    ├── [token valid]     → navigate to screen X
                    └── [token not valid] → navigate to screen Y
```

---

## 4. State Management Specification

### Cubit: `SplashCubit`
- Located at: `ui/presenters/splash/bloc/splash_cubit.dart`
- State file: `ui/presenters/splash/bloc/splash_state.dart`
- State is built with **Freezed**

### Status Enum
```
SplashStatus {
  initial,
  loading,
  tokenValid,
  tokenNotValid,
}
```

### Method: `init()`
- Called immediately when the screen is first rendered
- Emits `loading` status first
- Waits **1 second** (via `Future.delayed`)
- After the delay:
    - Currently: emits `tokenValid` directly (placeholder)
    - Future: will call the repository to validate the stored token, then emit `tokenValid` or `tokenNotValid` based on the result
- Error handling must use `.then().catchError()` — no `try/catch`

---

## 5. UI Implementation Rules

### BlocProvider
- Wrap the screen with `BlocProvider<SplashCubit>`
- Cubit must be created and `init()` called immediately inside `create`

### BlocListener
- A `BlocListener<SplashCubit, SplashState>` must be present
- `listenWhen`: fires only when `status` changes
- Inside the listener, use plain `if/else` to check `state.status` directly
- **No `maybeWhen`, `when`, `map`, or `maybeMap`**
- Navigation:
    - `state.status == SplashStatus.tokenValid` → `context.go(AppRoutes.x)`
    - `state.status == SplashStatus.tokenNotValid` → `context.go(AppRoutes.y)`
- Navigation must use **GoRouter only** (`context.go`) — no `Navigator.push`

### BlocBuilder
- Not required for the current UI (static layout)
- Can be added later if the splash UI needs to react to state visually

---

## 6. Future Extension Point

When token validation is ready, the following change is made **only inside `SplashCubit.init()`**:

```
Current:
  Future.delayed(1 second) → emit tokenValid

Future:
  Future.delayed(1 second) → call SplashRepository.validateToken()
      .then(isValid → emit tokenValid or tokenNotValid)
      .catchError(→ emit tokenNotValid)
```

The UI layer requires **zero changes** when this extension is made.

---

## 7. File Structure

```
ui/presenters/splash/
├── splash.dart                         # Screen (BlocProvider + BlocListener + UI)
└── bloc/
    ├── splash_cubit.dart
    └── splash_state.dart
```

---

## 8. Cross-Reference
- **`state_management_guideline.md`**: `.then().catchError()` rule, BlocListener if/else pattern
- **`routing_guideline.md`**: GoRouter-only navigation via `context.go()`
- **`architecture_di_guideline.md`**: When token validation is added, register `SplashRepository` in `locator.dart`
- **`Project_structure_schematic.md`**: Splash is the `initialLocation` of the GoRouter config