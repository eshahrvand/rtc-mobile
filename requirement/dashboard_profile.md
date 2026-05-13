# Feature Spec: Profile Information Screen

## 1. Overview
The Profile Information screen displays the current user's profile data in read-only mode.
The data is sourced from `HomeCubit` state — no separate Cubit is created for this screen.

---

## 2. User Flow

```
Dashboard Drawer Menu
    └── user taps profile avatar/photo
            └── context.push(AppRoutes.profile)
                    └── Profile Screen opens
                            └── displays user info (read-only)
```

---

## 3. Navigation Entry Point

- Triggered from `RtcDrawer` when the user taps the profile avatar/photo in the drawer header
- Navigation uses GoRouter: `context.push(AppRoutes.profile)`
- The profile route must be registered in the router file by the developer

---

## 4. State Management

### No New Cubit
This screen does **not** have its own Cubit.
All data is already available in `HomeCubit` state and is passed into this screen as constructor parameters at the time of navigation.

### Data Source
The data displayed on this screen comes from `HomeCubit` state fields.
The fields required are whatever is visible in the screenshot — defined by `ui-figma/profile/profile_info.png`.

### Passing Data
Data is passed via GoRouter `extra` parameter at navigation time:

```dart
// in RtcDrawer — on profile avatar tap
context.push(
  AppRoutes.profile,
  extra: {
    // pass fields visible in screenshot from HomeCubit state
    // e.g. 'fullName': state.fullName,
    // e.g. 'phoneNumber': state.phoneNumber,
    // developer fills this in based on available state fields
  },
);
```

The route builder extracts and passes the data to the screen widget.

---

## 5. UI Structure

```
ProfileScreen (StatelessWidget)
└── Scaffold
    ├── appBar: RtcAppBar(title: '...', onBack: () => context.pop())
    └── body: SingleChildScrollView
            └── Column
                └── [fields visible in screenshot — replicate exactly]
                    each field → RtcTextField (readOnly: true)
```

---

## 6. Component Usage: `RtcTextField` in ReadOnly Mode

All input fields on this screen use the existing `RtcTextField` widget from `lib/widget/` with `readOnly: true`.

```dart
RtcTextField(
  readOnly: true,
  // pass label, value, and any other visible props from screenshot
  // TODO: confirm RtcTextField supports readOnly — if not, wrap with IgnorePointer or AbsorbPointer
)
```

**Do not create a new widget for read-only display.**
Use `RtcTextField` with `readOnly: true` for every field visible in the screenshot.

### Exception: سقف اعتبار Field
The "سقف اعتبار" (credit limit) field may require a visual treatment that `RtcTextField` cannot support directly (e.g. a special badge, colored indicator, or custom suffix).

Apply this decision in order:
1. First, **try to implement it using `RtcTextField`** with available props (suffix, prefix, decoration overrides)
2. If `RtcTextField` cannot cover the visual requirement from the screenshot:
    - Copy the internal implementation of `RtcTextField` as a starting base
    - Create a new component: `lib/widget/rtc_credit_limit_field.dart`
    - Modify only what is necessary to match the screenshot
    - Keep `readOnly: true` — this field is never editable
    - All colors and styles → `// TODO: replace with theme values`
3. Do **not** build the new component from scratch — always derive it from `RtcTextField`

---

## 7. UI Rules

- Replicate the screenshot **exactly** — no extra fields, no rearranged layout
- Do not add any field or element not visible in `profile_info.png`
- Do not make any field editable — all fields are `readOnly: true`
- All colors and text styles → `// TODO: replace with theme values`
- All icons are **SVG** — use the project's SVG rendering widget
- Screen file must stay under **150–200 lines**
- If the screen exceeds the line limit, extract sections into files under `widget/`
- No business logic inside the screen file
- Back navigation uses `context.pop()` via GoRouter — never `Navigator.pop`

---

## 8. File Structure

```
ui/presenters/profile/
├── profile.dart                  # Screen (StatelessWidget)
└── widget/
    └── (extracted sub-widgets if profile.dart exceeds 200 lines)
```

No `bloc/` folder — this screen has no Cubit.

---

## 9. Figma Assets

Place screenshot in:
```
ui-figma/profile/
└── profile_info.png      ← full profile screen UI
```

The AI agent must read this image before writing any code.
Implement only what is visible in this image — nothing more.

---

## 10. Cross-Reference
- **`ui_figma_implementation_guideline.md`**: screenshot replication rules, lib/widget/ scan process
- **`routing_guideline.md`**: GoRouter only — `context.push()` to enter, `context.pop()` to go back
- **`ui_component_system_guideline.md`**: 150–200 line limit, rtc_ prefix rule
- **`home_screen_spec.md`**: HomeCubit state fields available for passing to this screen
- **`drawer_menu_spec.md`**: navigation trigger point (profile avatar tap in drawer header)