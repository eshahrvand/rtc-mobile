---
name: flutter-firebase-analytics
description: Adds Firebase Analytics event logging (screen views + button taps) to Flutter apps that follow Clean Architecture with Cubit/Freezed state management and GoRouter. Use this skill whenever the user asks to add Firebase Analytics, event tracking, screen tracking, or button-tap logging to a Flutter app, or mentions instrumenting screens/widgets/buttons with analytics tags. Always consult this skill before writing any Firebase Analytics integration code for Flutter, even if the user only asks for "just the screen tracking" or "just button clicks" — this skill defines the full wiring (service, GoRouter observer, button auto-logging) needed for either to work correctly.
---

# Flutter Firebase Analytics Instrumentation

Adds automatic Firebase Analytics event logging to a Flutter app across two surfaces:

1. **Screen views** — automatically logged whenever GoRouter navigates, no per-screen
   code required.
2. **Button taps** — automatically logged whenever the app's custom button widget
   (`rtc_button` or equivalent) is tapped, no per-button boilerplate required.

This skill assumes (and preserves) a Clean Architecture Flutter codebase using
Cubit + Freezed for state management, GoRouter exclusively for navigation, and a
`.then().catchError()` convention rather than `try/catch`/`async-await` in
data/service layers. Always check the target codebase's existing conventions first and
match them — do not introduce `async/await`, `try/catch`, `build_runner`-only patterns,
or any state management approach not already used in the project.

## Step 0 — Confirm dependencies

Check `pubspec.yaml` for `firebase_analytics` and `firebase_core`. If missing, add them
and tell the user they still need to run their normal Firebase setup
(`flutterfire configure` or manual `google-services.json` / `GoogleService-Info.plist`)
if that hasn't been done yet — this skill does not perform Firebase project setup itself,
only the in-app instrumentation.

## Step 1 — Create a single `AnalyticsService` wrapper

Do NOT call `FirebaseAnalytics.instance` directly from UI or Cubit code. Create one
central service so logging stays consistent and easy to change later:

```dart
import 'package:firebase_analytics/firebase_analytics.dart';

class AnalyticsService {
  AnalyticsService(this._analytics);

  final FirebaseAnalytics _analytics;

  FirebaseAnalyticsObserver get observer =>
      FirebaseAnalyticsObserver(analytics: _analytics);

  void logScreenView(String screenName) {
    _analytics.logScreenView(screenName: screenName);
  }

  void logButtonTap(String buttonName, {Map<String, Object>? params}) {
    _analytics.logEvent(
      name: 'button_tap',
      parameters: {
        'button_name': buttonName,
        if (params != null) ...params,
      },
    );
  }
}
```

Place this file following the project's existing folder conventions for shared/core
services (mirror where similar app-wide singleton services already live — e.g. next to
other services registered in the DI/service-locator setup). Register it in the existing
dependency injection setup the same way other services are registered — do not introduce
a new DI mechanism if one already exists (e.g. `get_it`, manual constructor injection,
`Provider`, etc.).

**Naming convention for event/screen names**: use the raw class name of the
screen/widget as-is (e.g. `OrderDetailScreen`, `PreInvoiceScreen`) — do not snake_case,
lowercase, or otherwise transform it. This keeps the Firebase Analytics dashboard names
identical to the source code, which makes cross-referencing trivial. The one exception:
Firebase Analytics screen/event names must not exceed 40 characters and must match
`^[a-zA-Z][a-zA-Z0-9_]*$` — if a class name is longer or contains characters outside this
set, truncate/sanitize it and note this in a code comment at the point of use.

## Step 2 — Automatic screen-view tracking via GoRouter

Do NOT add manual `analytics.logScreenView(...)` calls inside every screen's `initState`
or Cubit. Instead, wire a single `NavigatorObserver` into the app's existing
`GoRouter` instance:

```dart
final goRouter = GoRouter(
  navigatorObservers: [
    analyticsService.observer, // FirebaseAnalyticsObserver from Step 1
  ],
  routes: [
    // ...existing routes, unchanged
  ],
);
```

`FirebaseAnalyticsObserver` (from the `firebase_analytics` package) automatically fires a
`screen_view` event on every route push/pop, using the route's `name` if the `GoRoute` has
one, or the widget's `runtimeType` as a fallback. Since this project already uses
GoRouter for all navigation, check each `GoRoute` definition:

- **If routes already have a `name:` parameter** (recommended GoRouter practice), the
  automatically-logged screen name will be that route name — confirm these names match
  the actual screen class names per the naming convention above, and add/fix `name:` on
  any `GoRoute` missing it. Do NOT rename existing route names if other code (e.g.
  `context.goNamed(...)` calls) already depends on the current name — instead add a
  separate explicit screen name if there's a mismatch (see fallback below).
- **If a route has no `name:` and adding one is risky** (many call sites reference it),
  add `screenName` to that specific route's builder via a lightweight wrapper widget that
  calls `analyticsService.logScreenView(...)` once in `initState`, only for that specific
  screen — do not do this project-wide, since the whole point of using the observer is to
  avoid per-screen code.

**Do NOT modify unrelated `GoRoute` configuration** (paths, redirects, guards) while doing
this — only touch the `name:` field and the top-level `navigatorObservers` list.

## Step 3 — Automatic button-tap tracking

Locate the project's custom button widget (commonly prefixed `rtc_`, e.g. `RtcButton`,
matching this project's `rtc_`-prefixed custom widget convention). Wrap its tap handling
so every tap is automatically logged, without requiring changes at every call site:

```dart
class RtcButton extends StatelessWidget {
  const RtcButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.analyticsId, // optional override; defaults to `label`
  });

  final String label;
  final VoidCallback onPressed;
  final String? analyticsId;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      // ...existing styling, unchanged
      onPressed: () {
        getIt<AnalyticsService>().logButtonTap(analyticsId ?? label);
        onPressed();
      },
    );
  }
}
```

Key points:

- **Do NOT change the public API in a breaking way.** `analyticsId` must be optional
  with a sensible default (falling back to the button's visible `label`/text) so every
  existing call site keeps working without modification.
- **Do NOT rebuild or restyle the button widget.** Only wrap the existing `onPressed`
  callback with a logging call before it runs.
- If the project has multiple custom button variants (e.g. `RtcButton`,
  `RtcOutlinedButton`, `RtcIconButton`), apply the same wrapping pattern to each one
  individually — do not consolidate them into a single widget as part of this task.
- If a button has no visible text (icon-only buttons), `analyticsId` becomes required at
  that call site instead of optional — flag these cases explicitly rather than logging a
  blank/generic name.

## Step 4 — Verification checklist

After wiring, confirm:

- [ ] `AnalyticsService` created once, registered in the existing DI setup, and is the
  only place `FirebaseAnalytics.instance` is referenced directly.
- [ ] `GoRouter`'s `navigatorObservers` includes the analytics observer; no manual
  per-screen `logScreenView` calls were added except where explicitly justified in
  Step 2.
- [ ] Every custom button widget (`rtc_`-prefixed) logs a `button_tap` event through
  `AnalyticsService`, using the button's label as the default event name.
- [ ] No existing call site of any button widget was forced to change (the `analyticsId`
  parameter is additive/optional wherever a label already exists).
- [ ] No `async/await` or `try/catch` introduced in files that use
  `.then().catchError()` elsewhere in the project.
- [ ] No routing, theming, or localization files modified beyond the specific
  `name:`/`navigatorObservers` additions described in Step 2.
- [ ] `build_runner` was not run (this instrumentation requires no code generation).

## Common pitfalls

- **Duplicate screen views**: if both a `GoRoute.name` AND a manual `logScreenView` call
  exist for the same screen, Firebase will log two events per navigation. Pick one
  mechanism per screen, not both.
- **PII in event parameters**: never pass user-identifying data (phone numbers, national
  IDs, order contents) as event parameters — only structural identifiers like screen/
  button names. Flag this explicitly to the user if any call site risks it.
- **Debug builds flooding Analytics**: Firebase Analytics events from debug builds land
  in the same project by default. If the project already has a convention for
  separating debug/release analytics (e.g. `setAnalyticsCollectionEnabled(false)` in
  debug), preserve it; otherwise mention this to the user as an optional follow-up, not
  something to silently add.