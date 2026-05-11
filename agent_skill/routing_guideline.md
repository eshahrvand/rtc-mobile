# Engineering DNA: Routing & Navigation

## 1. Engineering Mindset
The developer views routing as a **"Passive Transport & Observability Layer"**. They prioritize flat accessibility and integrated tracking over complex navigation hierarchies.

- **Problem Solving via Flatness:** Although URL paths appear hierarchical (e.g., `/setting/personal/information`), the internal configuration is a flat list of routes. This reveals a mindset that treats every screen as a "Peer," simplifying navigation logic by avoiding the cognitive load of nested navigators.
- **Trade-off: Speed over Type-Safety:** By using a `Map<String, dynamic>` for `extra` parameters, the developer chooses rapid development and flexibility. They accept the risk of runtime casting errors in exchange for not having to write boilerplate for typed route classes.
- **Observability as a First-Class Citizen:** Navigation is never "just" navigation. Every route transition is strictly tied to a telemetry event. This suggests a philosophy where if a user movement isn't tracked, it didn't happen.

## 2. Decision Patterns
- **Path-String Centralization:** Every path is defined as a top-level global constant. This creates a "Centralized Directory" pattern where the application's structure can be understood by reading a single file without looking at the widgets.
- **Environment-Aware Entry:** The `initialLocation` is the result of a platform-logic check (Web vs. PWA vs. App). This reveals a "Gatekeeper" pattern where the very first decision the app makes is about the environment it lives in.
- **Naming Logic:** Paths follow a strictly REST-like semantic structure: `[Category] / [Sub-Category] / [Action] / [Resource]` (e.g., `/data/entry/search/food`). This reveals a desire for the URL to tell a story about the user's intent.

## 3. Dependency & Communication Rules
- **The Router as a Translator:** The router's primary job is to take raw data (Strings and Maps) and translate them into Widget parameters. 
- **Passive State Passing:** The router does not "own" or "create" state; it merely transports "Extra" data objects. If a screen requires data, it must be provided at the moment of navigation as a bundle.
- **Boundary Rule:** Business logic never triggers navigation directly; instead, the UI layer responds to Cubit states or user actions by calling the global router.

## 4. Implicit Rules
- **The Analytics Ritual:** Every route builder **must** invoke the screen tracking event before returning the widget. Violating this breaks the project's data-driven engineering goal.
- **Manual Parameter Extraction:** Parameters are extracted and cast manually within the `GoRoute` builder. There is no automated serialization; the developer relies on implicit knowledge of what keys exist in the `args` map.
- **Global Singleton Strategy:** The router is a global `final` instance. It is treated as part of the core infrastructure, similar to a database helper, rather than a dependency that needs to be injected.

## 5. Replication Guide

To implement a new route (e.g., "Export Data") in this style, follow these exact steps:

### Step 1: Define the Path Constant
Add a new string constant at the top of the router file. Use semantic categorization.
- *Abstract Logic:* `CONSTANT pathExportData = '/settings/data/export'`

### Step 2: The Tracking Link
Ensure the screen name is added to the central `ScreenName` enum to maintain the link between navigation and analytics.

### Step 3: Register the Route
Add a `GoRoute` to the flat list. The builder must follow this sequence:
1. Trigger the tracking event.
2. Extract arguments from `state.extra` (if any) and cast them to a `Map`.
3. Pass individual keys from the map into the Widget constructor.
- *Abstract Logic:*
  ```
  GoRoute(
    path: pathExportData,
    builder: (context, state) {
      TRACK_EVENT(ScreenName.exportData);
      VAR args = state.extra AS MAP;
      RETURN ExportDataScreen(format: args['format']);
    }
  )
  ```

### Step 4: Platform Gatekeeping
If the new feature is platform-specific, update the `initialLocation` or add logic inside the builder to redirect or show a platform-appropriate UI (e.g., `iosInstallApp` pattern).
