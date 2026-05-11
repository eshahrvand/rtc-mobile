# Engineering DNA: UI Implementation from Figma

## 1. Purpose
This guideline defines the exact process for implementing UI screens from Figma screenshots.
The AI agent's job is to **replicate — not interpret.** Nothing is added, removed, or "improved" without explicit approval from the developer.

---

## 2. Input Convention

### Screenshot Location
All Figma screenshots for a screen are placed inside:
```
ui-figma/
└── [screen_name]/
    ├── screen_main.png
    ├── screen_state_loading.png
    ├── screen_state_error.png
    └── ...
```

The agent reads every image in the folder before writing a single line of code.

### What the Screenshot Defines
- Layout structure (Stack, Column, Row, positioning)
- Spacing and padding (estimated from proportions)
- Component types (button, text field, card, list, etc.)
- Component states (loading, empty, error, filled)
- Icon positions and approximate sizes

### What the Screenshot Does NOT Define (developer provides separately)
- Colors and gradients → provided by developer from the theme system
- Typography styles → provided by developer from `text_theme.dart`
- Exact pixel values → developer reviews and adjusts after first implementation
- Business logic and data binding → handled separately in the Cubit

---

## 3. Widget Library First Rule

Before writing any widget code, the agent **must** scan `lib/widget/` and identify all available custom widgets.

### Mandatory Check Process
1. List all files in `lib/widget/`.
2. For every UI element in the screenshot, check if a matching custom widget exists.
3. Use the custom widget if it exists — never replace it with a raw Material widget.
4. Only use a raw Material/Flutter widget if no custom equivalent exists in `lib/widget/`.

### Known Custom Widget Prefix
All project-specific widgets carry the `rtc_` prefix. Examples:
```
rtc_text_field
rtc_icon_button
rtc_image
rtc_button
rtc_appbar
rtc_text
...
```

### Decision Table

| Situation | Action |
|---|---|
| Custom widget exists in `lib/widget/` | Use it. No exceptions. |
| Custom widget exists but needs a minor prop | Use it and pass the prop. Ask developer if prop doesn't exist. |
| No matching custom widget exists | Build a plain implementation inline or as a new extracted widget. |
| Unsure if a widget covers the use case | Ask developer before proceeding. |

---

## 4. Implementation Rules

### 4.1 Pixel-Perfect Replication
- Implement exactly what is visible in the screenshot.
- Do not add UI elements that are not in the screenshot.
- Do not remove UI elements that are visible in the screenshot.
- Do not rearrange the layout based on "better UX" judgment.

### 4.2 Theme Placeholders
Since colors and text styles are provided by the developer after the first pass, use clearly marked placeholders:
```dart
// TODO: replace with theme color
color: Colors.grey,

// TODO: replace with AppTextStyle
style: TextStyle(fontSize: 14),
```
Never hardcode a final color or style. Always mark it as a TODO for the developer to fill in.

### 4.3 No Logic in UI
The UI file contains only layout and widget composition.
- No API calls
- No business logic
- No direct repository or database access
- State is received from the Cubit via `BlocBuilder`; actions are sent via `context.read<FeatureCubit>().methodName()`

### 4.4 File Size Rule
Each screen file must stay within **150–200 lines**. If the implementation exceeds this:
- Extract logical visual sections into separate files under `widget/`
- Naming: `[feature]_[description]_widget.dart`
- See `ui_component_system_guideline.md` for full extraction rules

### 4.5 Nothing Added Without Approval
The agent must not:
- Add animations not visible in the screenshot
- Add padding/margin "for aesthetics"
- Swap a component for a "better" one
- Add error handling UI not shown in the screenshot
- Add any feature or visual element not explicitly present

If the agent is uncertain about any element, it **stops and asks** before continuing.

---

## 5. Workflow Order

```
Step 1 — Read all images in ui-figma/[screen_name]/
Step 2 — Scan lib/widget/ and list available rtc_ widgets
Step 3 — Map each UI element in the screenshot to a widget (custom or raw)
Step 4 — Implement layout structure first (Scaffold, Column, Stack, etc.)
Step 5 — Fill in components using rtc_ widgets where available
Step 6 — Mark all colors and text styles as TODO placeholders
Step 7 — Check file line count → extract widgets if over 200 lines
Step 8 — Present the result to the developer for review
```

---

## 6. Cross-Reference
- **`ui_component_system_guideline.md`**: Widget extraction rules and the 150–200 line limit.
- **`state_management_guideline.md`**: How the UI connects to the Cubit (BlocBuilder, BlocListener, if/else pattern).
- **`routing_guideline.md`**: How navigation is triggered from the UI (GoRouter only, via BlocListener or direct user action).