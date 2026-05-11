# Engineering DNA: Dependency Strategy & Package Philosophy

## 1. Package Selection Philosophy: "High-Performance Pragmatism"
The developer treats dependencies as **"Heavy Infrastructure"** rather than simple helpers. They avoid "package sprawl" by choosing comprehensive, ecosystem-standard solutions that solve entire categories of problems.

- **Infrastructure over Utilities:** They prefer "Big Rock" dependencies (Isar, Retrofit, BLoC) that define the architecture, while keeping "Small Pebble" UI helpers to a minimum. 
- **The "Community-First" Resilience:** The choice of `isar_community` over the official (and often stalled) Isar v3/v4 reveals a developer who values **active maintenance and community fixes** over official branding. They are willing to switch to community-maintained forks to ensure project longevity.
- **Deep Localization Integration:** The inclusion of `shamsi_date` and `sms_autofill` alongside standard localization tools indicates that regional requirements (Persian/Farsi support, Iranian SMS workflows) are baked into the core dependency strategy, not treated as afterthoughts.

## 2. Architectural Commitments
The `pubspec.yaml` reveals four non-negotiable architectural pillars:

- **The Networking Contract (Retrofit + Dio):** They deliberately chose a declarative, code-generated API layer. This commits the project to a **"Compile-Time Safe"** networking strategy where manual JSON parsing is strictly forbidden.
- **The Persistence Engine (Isar):** By selecting a NoSQL, high-performance database, they commit to an **"Offline-First"** architecture capable of handling complex relational queries without the overhead of SQLite.
- **The Reactive Core (BLoC/Cubit):** The commitment to `flutter_bloc` forces a strict separation between UI and Logic. There is no evidence of "lightweight" alternatives, suggesting a refusal to compromise on the predictability of the BLoC pattern.
- **The Decoupling Layer (GetIt):** The presence of `get_it` alongside BLoC indicates a **Service Locator** philosophy for dependency injection, allowing for the "Lazy Initialization" pattern identified in other guidelines.

## 3. Risk & Stability Signals
- **Production-Hardened Selection:** The developer favors packages that are "de facto" standards (Sentry, Firebase, ConnectivityPlus). They prioritize observability (`sentry_flutter`) and reliability over "trendy" new packages.
- **Aggressive Code Generation:** The heavy `dev_dependencies` section (`freezed`, `json_serializable`, `retrofit_generator`, `isar_community_generator`) reveals a **"Zero-Boilerplate"** discipline. They trade a slightly longer build time for 100% type safety and reduced human error in data mapping.
- **Mixed Stability Stance:** While most versions use the caret (`^`) for flexible updates, they use specific `-dev` versions for critical infrastructure (`isar_community`). This shows a willingness to adopt pre-release versions if it provides a competitive advantage in performance or stability.

## 4. Implicit Rules & Absences
- **The "Build vs. Buy" Line:** The developer uses a local `path` for `iap` and a `git` reference for `wave_blob`. This reveals an implicit rule: **"If it's business-critical (payments) or specialized (audio), own the source code or use a fork."**
- **No "God-Object" UI Kits:** There are no "UI component libraries" (like GetWidget or VelocityX). This confirms the **"Component DNA"** of building custom, brand-specific widgets from scratch using only low-level Material/Cupertino foundations.
- **Redundant Responsive Logic:** The presence of both `responsive_framework` and `flutter_screenutil` suggests a dual-strategy for handling device diversity: one for layout reflow and one for pixel-perfect scaling.

## 5. Replication Guide: The "New Project" Checklist

When starting a new feature or project in this style, follow this prioritized decision framework:

### Priority 1: The "Quad-Core" Infrastructure
These must be added first and define the project's skeleton:
1. `flutter_bloc`: The state container.
2. `get_it`: The service locator.
3. `isar_community`: The persistence engine.
4. `retrofit` + `dio`: The communication layer.

### Priority 2: The "Type-Safe" Generator Stack
NEVER write manual mappers. Always add:
- `freezed` + `json_annotation` + `build_runner`

### Priority 3: The Observability Layer
If the app is intended for production, these are non-negotiable from Day 1:
- `sentry_flutter` for error tracking.
- `firebase_analytics` for business events.

### Priority 4: Decision Framework: "To Package or Not?"
- **UI Element?** Build it in-house (Caltivita-prefixed).
- **Domain logic?** Build it in-house.
- **Complex OS Integration (Scanner, Health, Alarm)?** Use a high-quality, maintained package.
- **Data Visualization?** Use a specialized library (`fl_chart`).

---

## Connection Points

- **To `clean_architecture_guideline.md`**: The `retrofit` and `isar` choices provide the technical enforcement for the "Branching Repository" and "Data Bundle" patterns.
- **To `state_management_guideline.md`**: `flutter_bloc` is the engine that drives the "Omni-Cubit" and "Status-Driven UI" philosophy.
- **To `theme_system_guideline.md`**: The absence of UI kits explains why the developer had to build a custom `MaterialColor` and `BoxShadow` system from scratch.
- **To `local_data_layer_guideline.md`**: The choice of `isar_community` enables the "High-Performance Cache" and "Relational Cleanup" logic through its fast query engine.
