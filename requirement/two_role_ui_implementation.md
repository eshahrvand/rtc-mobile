# Two-role Flutter implementation and service handoff

The agent/employee UI uses the project's existing Cubit/GetIt, RTC widgets,
theme, localization and Avat Media Picker. Backend integration now follows the
supplied Swagger and privacy-policy guide.

For current backend gaps and contract questions, see
[backend_integration_gaps.md](backend_integration_gaps.md).

## Connected production behavior

- The locator registers `WorkspaceRepository.remote(WorkspaceService)`.
- Authenticated `/accounts/me` responses update the app-wide policy gate and
  retain policy status, postal code, store count, wallet flag and documents.
- Only the two documented 403 gate codes block the app and suppress generic
  error snackbars. Staff never gate; employees cannot accept for their agent.
- Acceptance sends the displayed integer version, then reloads `/me`. A 422
  outdated-version error reloads text and clears the checkbox. Recheck, startup
  and foreground re-entry use `/me`. Logout and expired sessions reset state.
- Gated screens have bottom-sheet styling with rounded top corners. Normal
  screens are unmounted and recreated on unlock; late screen-cubit emissions
  after disposal are ignored. Branch and terms screens refresh on remount.
- Protected policy HTML is fetched with Dio, converted locally to PDF and saved
  through the native Downloads channel used by pre-invoices.
- Stores and sales persons support all response pages and detail endpoints.
  Employee create/update/delete use the supplied payload and position enums.
- Branch search sends `search` after a one-second debounce, ignores stale
  responses and cancels pending debounce on close/logout/gating.
- Order DTOs retain store, creator, receiver and new financial/wallet fields.
  Creation sends selected store and optional alternate receiver. The list's
  branch filter is reflected in its UI and persists through pagination.
- Active home slides use `GET /content/sliders/active` for both roles, sorted by
  position and sized using the supplied image aspect ratio. Empty/null/204/404
  responses hide the entire section. HTTP(S) URL actions open the external
  browser; `screen=orders` selects the existing orders tab. Other screen values
  are intentionally inactive until supplied by the backend/product owner.

## UI behavior

- Role-dependent drawer/profile, terms page, branch management, employee forms,
  home banners and refund confirmation reuse existing components.
- Agents with multiple branches have a required initial selection step and six
  steps overall. Employees and single-branch agents use five steps. The selection
  is invoice-local and preserved on back.
- Branch and position selectors use bottom sheets. Invoice branch content starts
  12 logical pixels below the step indicator, matching the revised Figma frame.
- Employee national-ID/mobile errors appear under the fields; standard 14 px
  text/hint styling is used for these and alternate-recipient inputs.
- The avatar and edit icon both open single-image Avat Media Picker without
  PDF/file selection or the national-card overlay.
- Employee dashboards hide the commission-increase message. Dashboard order
  charts only display statuses with supported Persian translations.
- Consumer-total rows are shared by all delivery variants. Independent consumer
  unit prices are retained with cart quantities; missing data stays unknown.
- Commission reports only filter by year, month and search. Branch filtering
  and the `store` query parameter were removed per the corrected contract.
- Position choices currently come from the three documented Swagger enums.
  No dynamic choices endpoint has been supplied.
- Carousel cards keep 16 px corners, the existing `primaryShadow`, and a subtle
  border. The carousel extends through the dashboard side padding to reveal the
  adjacent slide (329 px image with a 12 px gap at the 375 px design width).

## Pending backend contracts

Refund and consumer pricing remain pending. Own-profile avatar upload
uses `POST /media/images` with `user_avatar`, followed by
`PATCH /accounts/users/{current-user-id}` with only the image UUID in `avatar`.
Success requires both requests. Other employees' photos are read-only.
Production does not use guessed endpoints or successful mock responses.
Profile/schema/permission questions are detailed in the Persian report.
Refund actions and badges are temporarily hidden for both roles until its
service is available. Employees do not see commission reports in the drawer.

## Isolated preview

```sh
flutter run -t lib/main_ui_preview.dart
```

The separate entry point has a navigation gallery and role selectors. It uses
in-memory actions and isolated mock preferences, rejects HTTP and disables
analytics without initializing Firebase/Sentry/notifications. Production auth is
unchanged. `/preview/invoice?branch=true&branches=1` shows the single-branch case.

## Validation and code generation

Latest slider validation ran 14 related tests: seven backend contract/state
tests, six carousel widget tests and the existing dashboard banner render test.
All passed, including external-browser actions, the orders tab for both roles,
empty responses, aspect-ratio sizing, adjacent-slide visibility and styling.
The full application suite was not run, as requested.

Earlier follow-up validation passed nine tests related to avatar upload,
own-profile picker, read-only employee photo, invoice branch selection and
commission period filtering.

The broader command below documents coverage from earlier integration work:

```sh
flutter test --no-pub test/backend test/workspace \
  test/dashboard_daily_chart_test.dart \
  test/commission_report_cubit_test.dart test/commission_report_widget_test.dart
```

Tests cover request payloads, query filters, policy restrictions/422 recovery,
server search/debounce/stale responses, PDF orchestration, role UI, avatar picker,
drawer navigation, form validation, selectors and 375/320 px renders. Local HTTP
adapters avoid live-account mutations. Native PDF rendering and saving still
need device-level QA with actual protected HTML.

The installed Dart 3.13 SDK is incompatible with the project's old generators.
Changed Freezed/JSON/Retrofit outputs were generated in a temporary package with
Dart 3.9 and matching generator versions, then copied back. Application
dependencies were not upgraded. Workspace states remain explicitly immutable;
legacy Freezed states keep generated implementations.
