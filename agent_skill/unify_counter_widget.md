# Unify Build Counter Widgets

## Role

You are a senior Flutter developer. Your task is to find three duplicate counter-style widgets in the codebase, analyze their differences, merge them into a single reusable widget with parameters, and replace all usages.

---

## Step 1 — Investigate First (Do NOT write any code yet)

Before writing a single line of code, do the following:

1. Search the entire codebase for the 3 `buildCounter` widgets (or methods named similarly — e.g., `_buildCounter`, `buildCounterWidget`, `_counterWidget`, etc.)
2. For **each one**, document:
   - File path and method/class name
   - All visual properties (color, size, font, icon, shape, border, etc.)
   - All behavioral properties (onTap, onIncrement, onDecrement, onChanged, etc.)
   - What data it displays (label, value, unit, min, max, etc.)
   - Where it is used (which screen/widget calls it)

3. Build a **diff table** in your mind — what is identical across all 3, and what differs.
   - Identical parts → become the widget body
   - Differing parts → become constructor parameters

Only after completing this investigation, proceed to Step 2.

---

## Step 2 — Design the Unified Widget

### Naming Convention

- Widget class name: `RtcCounterWidget` (follow the existing `rtc_` prefix convention of this project)
- File name: `rtc_counter_widget.dart`
- Destination folder: `lib/core/widgets/` (or the existing `widgets/` folder used in this project — use whatever path already exists)

### Parameter Design Rules

- Every visual or behavioral difference found in Step 1 **must** become a named parameter
- Parameters that are the same in all 3 usages **should** have a default value matching the current behavior
- Parameters that differ across usages **must not** have a default value (force the caller to be explicit)
- Do not add any parameter that is not needed by at least one of the existing 3 widgets
- Do not add features, animations, or logic that do not already exist in the original widgets

### Constructor Example Pattern

```dart
class RtcCounterWidget extends StatelessWidget {
  const RtcCounterWidget({
    super.key,
    // required params — differ across usages
    required this.value,
    required this.onChanged,
    // optional params — same in all 3 usages (with defaults)
    this.minValue = 0,
    this.maxValue = 99,
    // ... other params discovered in Step 1
  });
}
```

---

## Step 3 — Create the Widget File

1. Create the file at the correct `widgets/` path
2. The widget body must be a **faithful visual and behavioral merge** of the 3 originals
3. Do not use any new package or import not already present in the project
4. Do not run `build_runner`
5. Add a brief doc comment above the class explaining what it does and listing its parameters

---

## Step 4 — Replace All Usages

1. In every file that used one of the 3 original widgets, replace the call with `RtcCounterWidget(...)` and pass the correct parameters for that specific usage
2. Delete the 3 original `buildCounter` methods/widgets (if they were private methods inside a screen, remove those methods; if they were standalone widget classes, delete their files)
3. Do not touch any other part of those screen files — only the counter-related code

---

## Step 5 — Self-Check Before Finishing

Go through this checklist before submitting output:

- [ ] All 3 original usages now use `RtcCounterWidget`
- [ ] Each call site passes parameters that reproduce the original behavior exactly
- [ ] No original `buildCounter` code remains in the codebase
- [ ] The new file is in the correct `widgets/` folder
- [ ] No unrelated files were modified
- [ ] No new packages were added
- [ ] `build_runner` was not run
- [ ] Visual appearance at each call site is identical to before

---

## General Rules

- Investigate the full codebase before writing any code
- Make only the changes described above — nothing more
- Never modify unrelated files
- Never add unnecessary dependencies
- Never run `build_runner`
- If something is ambiguous (e.g., two widgets look almost identical but have a subtle difference), **keep that difference as a parameter** — do not silently unify it