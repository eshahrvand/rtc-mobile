# Task: Make `rtc_mobile` Flutter Web Build Fully Offline / Network-Isolated

## Context

`rtc_mobile` is a production Flutter app (Android, iOS, Web) with a Clean Architecture + Cubit/Freezed stack. The company backend now runs on a **local server** (`api.rtciran.com` resolved locally / on LAN), and company policy requires the **Flutter Web build** to run in an environment with **zero internet access**. This means every asset, font, script, or SDK resource that the web build currently fetches from any external CDN or Google-hosted URL must instead be bundled inside the app and served/loaded from local paths.

**Scope: Flutter Web target only.** Do not change Android/iOS behavior, build flavors, or any existing mobile networking logic. Do not touch unrelated files, Cubits, or features outside of what's listed below.

## Hard Constraints (project conventions — do not violate)

- Clean Architecture layering must be preserved.
- No `try/catch` — use `.then().catchError()` patterns where async handling is touched.
- No `build_runner` usage for this task (no codegen changes expected; this is a config/asset task).
- Do not modify GoRouter routes.
- Do not rename or restructure existing `rtc_`-prefixed widgets.
- Every change must be scoped strictly to web-offline-enablement. If a file must be touched for unrelated reasons, stop and flag it instead of changing it.

## Goal

After this task is complete, running the Flutter Web build (`flutter build web` output served locally) with **the client machine fully disconnected from the internet** must result in:
- The app loading and rendering correctly (no blank/broken CanvasKit load).
- All custom fonts rendering correctly.
- No console/network errors for blocked/unreachable external domains.
- Firebase Analytics either fully disabled for web, or safely no-op/fail-silently without blocking app startup or throwing visible errors.

---

## Step 1 — Audit: Find every external network dependency in the web build

Before changing anything, produce a full inventory. Search the following locations:

1. `web/index.html` — look for `<script src="https://...">`, `<link href="https://...">`, and any Firebase JS SDK `<script>` tags (commonly loaded from `www.gstatic.com/firebasejs/...`).
2. `pubspec.yaml` — check the `flutter: fonts:` section vs. what fonts are actually declared as local assets.
3. Search the codebase for `google_fonts` package usage:
   ```
   grep -rn "GoogleFonts\." lib/
   grep -rn "google_fonts" pubspec.yaml
   ```
4. Search for any hardcoded external URLs across the codebase:
   ```
   grep -rn "https://fonts.googleapis.com\|https://fonts.gstatic.com\|https://www.gstatic.com" .
   grep -rn "canvaskit" web/ build/
   ```
5. Check `web/manifest.json` and the service worker (`flutter_service_worker.js` is auto-generated — do not hand-edit it, but confirm what it references).
6. Check Firebase initialization code (likely in `lib/` under a `core/` or `firebase/` setup file, or in `web/index.html` via `firebase-config.js` / `firebase_options.dart`) to confirm which Firebase products are actually initialized (Analytics confirmed; FCM is planned but not yet implemented).

Output this audit as a checklist comment at the top of your PR/change summary before proceeding to fixes, so it can be reviewed.

---

## Step 2 — Fix: CanvasKit must load from local assets, not Google's CDN

By default, Flutter Web's CanvasKit renderer fetches `canvaskit.wasm` and related JS glue code from `https://www.gstatic.com/flutter-canvaskit/<engine-version>/`. This must be changed to load from a locally bundled copy.

1. Locate the CanvasKit files matching the exact Flutter engine version used in this project (`flutter --version` to confirm the engine commit/version).
2. Download the matching CanvasKit bundle (`canvaskit.wasm`, `canvaskit.js`, `chromium/` variant if used) **once, during this task, with internet access**, and place it under:
   ```
   web/canvaskit/
   ```
3. Configure the build to point to the local path instead of the CDN. This is typically done via the `--local-canvaskit` / by setting the CanvasKit base URL in `web/index.html`'s Flutter bootstrap config (`{{flutter_canvaskit_base}}` or the `FlutterLoader.load()` config options in newer Flutter versions — check the exact bootstrap snippet currently in `web/index.html` and adjust `canvasKitBaseUrl` to `"canvaskit/"` or equivalent relative local path).
4. Verify: with dev tools network tab open and internet disabled, reload the app and confirm zero requests go out to `gstatic.com`.

**Flag if:** the Flutter SDK version in use makes local CanvasKit hosting non-trivial (e.g. very old or very new Flutter versions may handle this bootstrap differently) — do not guess silently, report the exact bootstrap mechanism found and how it was adapted.

---

## Step 3 — Fix: Fonts — remove all runtime Google Fonts fetching

The project uses **custom/personal fonts** as the primary typeface, but an audit revealed `google_fonts` package calls are also present somewhere in the codebase, which trigger runtime downloads from `fonts.gstatic.com` even when a custom font is the visual default.

1. From the Step 1 grep results, list every `GoogleFonts.xxx()` call site.
2. For each one, replace it with the project's existing local custom font setup (i.e., reference the font family already declared in `pubspec.yaml` under `flutter: fonts:`, using standard `TextStyle(fontFamily: 'YourCustomFontFamily')` or the project's existing `ThemeData`/`TextTheme` pattern — check `lib/core/theme/` or equivalent for the established pattern already used in this app, and match it exactly rather than inventing a new one).
3. Remove the `google_fonts` dependency from `pubspec.yaml` entirely **if no legitimate remaining usage exists** after replacement. If any usage must remain for a valid reason, do NOT remove the dependency — instead set `GoogleFonts.config.allowRuntimeFetching = false` at app startup (before `runApp()`), and ensure the specific font files it needs are pre-bundled as local assets with matching font family names, so the package uses the bundled files instead of attempting a fetch.
4. Confirm all custom fonts referenced in `pubspec.yaml` actually have their `.ttf`/`.otf` files present under the declared asset path (e.g. `assets/fonts/`) — do not assume; check the files exist on disk.

---

## Step 4 — Fix: Self-host Firebase SDK locally (do not disable Firebase — make it network-optional)

**Important change of approach:** the isolated deployment is not always 100% offline — some client machines may occasionally gain internet access. So Firebase Analytics (current) and FCM (planned) should **not** be hard-disabled for web. Instead, all Firebase JS SDK files must be **downloaded once and self-hosted locally** in this repo, so:
- When the client has no internet: Firebase calls simply fail/timeout silently without blocking app startup or throwing visible errors (no dependency on reaching Google's CDN at all, since the SDK files themselves are already local).
- When the client *does* have connectivity at some point: Analytics events and, later, FCM push notifications work normally, because the only thing that was localized is the SDK **delivery** (loading the JS files from `gstatic.com`), not the Firebase **backend calls** themselves (those still legitimately go to Google's servers over the internet when available, which is expected and fine — only the SDK script loading needs to stop depending on the CDN).

1. Locate Firebase initialization code and all `FirebaseAnalytics` call sites (`grep -rn "FirebaseAnalytics" lib/`).
2. Check `web/index.html` for Firebase JS SDK `<script>` tags loaded from `https://www.gstatic.com/firebasejs/...`. Identify the exact SDK version(s) and modules loaded (e.g. `firebase-app.js`, `firebase-analytics.js`, and eventually `firebase-messaging.js` for FCM).
3. Download the matching SDK JS files for the exact version currently referenced (**with internet access, during this task**) and place them under:
   ```
   web/firebase/
   ```
4. Update `web/index.html` to load these scripts from the local path (`firebase/firebase-app.js`, etc.) instead of the `gstatic.com` URLs.
5. Ensure Firebase initialization (whether via the native Dart `firebase_core`/`firebase_analytics` plugins or JS interop — check which mechanism this project actually uses and report it) does not throw or hang the app when the underlying network call to Firebase's actual backend (not the SDK file, the live API call) fails due to no connectivity. Wrap Analytics calls so a failed/timed-out request is caught and ignored (using the project's `.then().catchError()` convention, not `try/catch`), rather than left unhandled.
6. Do not change Android/iOS Firebase behavior — this is web-scoped only.
7. For future FCM work (not part of this task, but leave the setup consistent with it): the local self-hosting approach above also covers `firebase-messaging-sw.js` — when FCM is implemented later, that service worker file should also be self-hosted under `web/firebase/` rather than fetched from `gstatic.com`, following the same pattern established here. Note this in your summary so the future FCM task can reuse this setup directly instead of re-solving it.

**Summary of the distinction to preserve:** "offline-safe" here means *the SDK code never depends on the internet to load*, not that *Firebase features are disabled*. Whenever the client machine has connectivity, Analytics/FCM should work exactly as before — only the artifact-loading step (fonts, CanvasKit, Firebase JS files) has been moved from Google's CDN to this repo's own `web/` assets.

---

## Step 5 — Verification

1. Run `flutter build web` and serve the output via a local static server (not `flutter run`, to match production deployment conditions).
2. Fully disable the machine's internet access (or use browser dev tools to block all external domains).
3. Load the app fresh (hard refresh, clear cache once to rule out stale cached CDN responses) and confirm:
    - App loads and renders without a blank screen or CanvasKit error.
    - All text renders in the correct custom fonts, no fallback/system font substitution.
    - No failed network requests to any external domain in the browser's Network tab (only requests to the local server / local static assets should appear).
    - No unhandled exceptions in console related to Firebase Analytics.
4. Provide a short before/after list of every external domain that was being contacted, and confirm each one is now eliminated or localized.

## Deliverables Summary Expected From the Agent

- The Step 1 audit checklist (what was found).
- List of files changed, with a one-line reason per file.
- Confirmation of the CanvasKit local hosting approach used (exact mechanism, since this varies by Flutter version).
- Confirmation that `google_fonts` runtime fetching is fully eliminated (either removed or fetching disabled + bundled).
- Confirmation that Firebase JS SDK files are now self-hosted locally (not disabled), with a note on which SDK version was bundled and where it's stored, plus confirmation that Analytics calls fail silently offline but still work when connectivity is present.
- Verification results from Step 5 (pass/fail per bullet, with specifics if anything failed).