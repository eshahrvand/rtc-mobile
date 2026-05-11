# Engineering DNA: Dependency Strategy & Package Philosophy

## 1. Package Selection Philosophy
The developer treats dependencies as **"Heavy Infrastructure"** — not simple helpers.
Every package added to the project is a long-term commitment, not a shortcut.

- **Prefer "Big Rock" over "Small Pebble":** Choose comprehensive, ecosystem-standard packages that solve an entire category of problems (e.g., networking, state management, persistence) rather than adding many small utility packages.
- **Community Health over Popularity:** Before adding any package, check: Is it actively maintained? Does it have recent commits? Is the issue tracker responsive? A less-famous but actively maintained package is always preferred over a famous but stale one.
- **Own What's Business-Critical:** If a feature is core to the product (payments, custom audio, proprietary logic), either build it in-house or use a `git`/`path` reference to a fork. Never depend on a pub.dev package for something the business cannot afford to break.

## 2. The Four Architectural Pillars
These are non-negotiable for every new project. They are selected first and define the skeleton of the codebase.

1. **State Management → `flutter_bloc` (Cubit):** The reactive core. No lightweight alternatives. Predictability is non-negotiable.
2. **Dependency Injection → `get_it`:** The service locator. Enables lazy initialization and decouples implementation from consumption.
3. **Networking → `dio` + `retrofit`:** Declarative, code-generated API layer. Manual JSON parsing is strictly forbidden.
4. **Local Storage → decided per project:** Chosen based on data complexity. Simple key-value → `shared_preferences`. Structured/relational data → a high-performance embedded database (evaluated at project start).

## 3. The Code Generation Rule
**Never write manual data mappers.** The following generator stack is always added:
- `freezed` + `freezed_annotation` — for immutable state and sealed classes.
- `json_serializable` + `json_annotation` — for DTO serialization.
- `retrofit_generator` — for API service interfaces.
- `build_runner` — as the orchestrator.

This is a trade-off: slightly longer build times in exchange for 100% type safety and zero human error in data mapping.

## 4. The Observability Rule
If the app is going to production, these are added from Day 1 — never retrofitted later:
- **Error tracking:** A crash/exception reporting service (e.g., Sentry or Firebase Crashlytics).
- **Analytics:** A business event tracking service (e.g., Firebase Analytics).

## 5. The UI Package Rule
**Never add a UI component library.** No GetWidget, VelocityX, or similar "God-Object" UI kits.
All UI components are built in-house using only low-level Material/Cupertino foundations, following the project's own component system and brand prefix conventions.

The only exception is **data visualization** (e.g., charts), where a specialized library is acceptable if building in-house is not practical.

## 6. The "To Package or Not?" Decision Framework
Before adding any new package, answer these questions in order:

| Question | Answer |
|---|---|
| Is it a UI element? | Build in-house. |
| Is it domain/business logic? | Build in-house. |
| Is it complex OS integration (camera, health, sensors)? | Use a well-maintained package. |
| Is it data visualization? | Use a specialized library. |
| Is it business-critical infrastructure? | Own the source via `path` or `git`. |

## 7. Version Pinning Strategy
- Use caret (`^`) for most packages to allow non-breaking updates.
- Use **exact versions** for packages that are part of the core architecture (networking, persistence, state management) if stability has been an issue.
- Avoid `-dev` or `-alpha` versions in production unless there is a specific, documented reason (e.g., a critical bug fix not yet in stable).

## 8. Cross-Reference
- **`architecture_di_guideline.md`**: The `get_it` choice enforces the lazy singleton DI pattern.
- **`state_management_guideline.md`**: `flutter_bloc` is the engine behind the Cubit and status-driven UI.
- **`local_data_layer_guideline.md`**: The persistence package choice determines the DAO implementation strategy.
- **`ui_component_system_guideline.md`**: The absence of UI kits is why the custom component system with brand prefix exists.