# Feature Spec: Dashboard Drawer Menu

## 1. Overview
The Drawer Menu is a side navigation panel accessible from the Home (Dashboard) screen.
It opens when the user taps the menu icon in the `RtcAppBar`.

---

## 2. User Flow

```
Home Screen
    └── user taps menu icon in AppBar
            └── Drawer opens (slides in)
                    └── user taps a menu item
                            └── Drawer closes + navigates to target screen
```

---

## 3. Trigger: Opening the Drawer

- The menu icon is placed in the `actions` or `leading` of `RtcAppBar` — replicate position exactly from screenshot
- Tapping the icon calls `scaffoldKey.currentState?.openDrawer()`
- The `Scaffold` in `HomeScreen` must have a `key` of type `GlobalKey<ScaffoldState>`
- The `drawer:` property of the `Scaffold` receives the `RtcDrawer` widget

---

## 4. Component: `RtcDrawer`
**File:** `lib/widget/rtc_drawer.dart`

### Constructor Parameters
```dart
RtcDrawer({
  required GlobalKey<ScaffoldState> scaffoldKey,
})
```

### Layout
Replicate **exactly** from screenshot `drawer_menu.png`.
Do not add, remove, or rearrange any element.

The layout sections visible in the screenshot must be implemented in order:
- **Header section** — replicate from screenshot (may include logo, user info, or branding)
- **Menu items list** — replicate each item exactly as shown
- **Footer section** — replicate from screenshot (may include version info, logout, or social links)

All text content, icons, and structure come from the screenshot.
All colors, text styles, dividers, and spacing → `// TODO: replace with theme values`
All icons are **SVG** — use the project's SVG rendering widget.

### Menu Items
Each menu item visible in the screenshot must be implemented.
Extract menu items into a private reusable sub-widget inside `rtc_drawer.dart`:

```dart
// internal widget — not exported
class _DrawerMenuItem extends StatelessWidget {
  final String title;
  final String iconPath;    // SVG asset path
  final VoidCallback onTap;
  // add any other fields visible in the screenshot (e.g. badge, arrow)
}
```

Tapping any menu item:
1. Closes the drawer: `scaffoldKey.currentState?.closeDrawer()`
2. Navigates using GoRouter: `context.go(AppRoutes.targetScreen)`

---

## 5. State Management

The Drawer does **not** have its own Cubit.
It is a stateless UI component that:
- Receives `scaffoldKey` as input
- Handles navigation directly via GoRouter on item tap
- Any dynamic data visible in the header (e.g. username, avatar) is passed as constructor parameters from the parent `HomeScreen` via `HomeCubit` state

If the screenshot shows dynamic data in the drawer header, add the corresponding fields to `HomeState` and pass them as parameters to `RtcDrawer`.

---

## 6. Integration in HomeScreen

```dart
// in home.dart
final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

Scaffold(
  key: _scaffoldKey,
  appBar: RtcAppBar(
    // menu icon tap opens drawer
    onMenuTap: () => _scaffoldKey.currentState?.openDrawer(),
    // ... other params
  ),
  drawer: RtcDrawer(
    scaffoldKey: _scaffoldKey,
    // pass any dynamic header data from state
  ),
  body: ...,
  bottomNavigationBar: ...,
)
```

---

## 7. Navigation Rules

- All navigation from drawer items uses **GoRouter only** — `context.go(...)` or `context.push(...)`
- **Never use** `Navigator.push` or any direct Navigator call
- Drawer always closes before navigating

---

## 8. UI Rules

- Replicate the screenshot **exactly** — no extra items, no rearranged layout
- Do not invent icons, labels, or sections not visible in the screenshot
- All colors and text styles → `// TODO: replace with theme values`
- All icons are SVG
- `RtcDrawer` file must stay under **150–200 lines** — if it exceeds this, extract `_DrawerMenuItem` or sections into separate private widgets within the same file
- No business logic inside `RtcDrawer` — only layout and navigation calls

---

## 9. File Structure

```
lib/
└── widget/
    └── rtc_drawer.dart              # Drawer component (used in HomeScreen)

ui/presenters/home/
└── home.dart                        # Scaffold with drawer: RtcDrawer(...)
```

No new Cubit or state file is needed for the drawer.

---

## 10. Figma Assets

Place screenshot in:
```
ui-figma/home/
└── drawer_menu.png       ← full drawer UI (open state)
```

The AI agent must read this image before writing any code.
Implement only what is visible in this image — nothing more.

---

## 11. Cross-Reference
- **`ui_figma_implementation_guideline.md`**: screenshot replication rules, lib/widget/ scan process
- **`routing_guideline.md`**: GoRouter only — `context.go()` for all drawer navigation
- **`ui_component_system_guideline.md`**: 150–200 line limit, rtc_ prefix convention
- **`home_screen_spec.md`**: Scaffold key setup and AppBar menu icon integration