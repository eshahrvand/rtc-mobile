# Prompt: UI Code Cleanup & Widget Extraction

## Your Task
Refactor and clean up the UI code for readability and proper widget organization.

**This is a structural cleanup task only.**

---

## CRITICAL RULES — Read Before Doing Anything

### ❌ Absolutely Forbidden
- Do NOT change any UI appearance
- Do NOT change any colors, text styles, paddings, margins, or decorations
- Do NOT change any theme values
- Do NOT change any functionality or logic
- Do NOT change any Cubit methods or state
- Do NOT change text direction (RTL/LTR)
- Do NOT add `Directionality` widgets
- Do NOT add `TextDirection` parameters
- Do NOT change `mainAxisAlignment`, `crossAxisAlignment`, or `textAlign` values
- Do NOT reorder Row/Column children
- The app is RTL — leave all directional properties exactly as they are in the current code

### ✅ Only Allowed Actions
- Extract large widget subtrees into separate files
- Move widgets between folders
- Add short inline comments
- Rename files/classes if they are in the wrong location (update all imports accordingly)

---

## Task 1 — Extract Widgets in Each Flow

### Rule
Every screen file must stay under **150–200 lines**.
If any screen or view file exceeds this, extract the largest widget subtree into a new file under the flow's `widget/` folder.

### Folder Structure to Follow
```
ui/presenters/[flow_name]/
├── [flow_name].dart
├── bloc/
└── widget/
    └── [extracted_widget].dart
```

### How to Extract
1. Identify subtrees in screen files that are self-contained visual blocks
2. Move them into `widget/` as a new `StatelessWidget`
3. Pass only the data the widget needs via constructor parameters
4. Update the parent file to use the new widget
5. Do not change what the widget looks like or how it behaves

---

## Task 2 — Audit `lib/widget/` and Relocate Flow-Specific Widgets

### Rule
`lib/widget/` is for widgets used in **more than one flow**.
If a widget in `lib/widget/` is only used in a single flow, move it to that flow's `widget/` folder.

### Steps
1. Go through every file in `lib/widget/`
2. Search the codebase for each widget's usage
3. If a widget is used in only one flow → move it to `ui/presenters/[flow_name]/widget/`
4. Update all imports in every file that references it
5. Do not change the widget's code — only move it

### Widgets that must stay in `lib/widget/`
Any widget used in 2 or more different flows stays in `lib/widget/`. Do not move these.

---

## Task 3 — Add Short Comments

Add a single short comment above each major section inside screen and view files.
Comments must be:
- In English
- One line only
- Descriptive of the section, not the code

### Examples
```dart
// AppBar with back button
RtcAppBar(...)

// Filter chip list
RtcChipList(...)

// Product list
ListView.builder(...)

// Submit button
RtcButton(...)
```

### Rules for Comments
- Do not add comments inside widget files — only in screen/view files
- Do not add comments to every line — only to major visual sections
- Do not explain logic — only describe what the section is

---

## Task 4 — Verify Imports

After all moves and extractions:
- Make sure every file has correct imports
- Remove any unused imports
- Do not add new packages

---

## Workflow — Flow by Flow

**Do not process the entire app at once.**

Follow this sequence for every flow:

```
Step 1 — Pick ONE flow (start with the first one)
Step 2 — Analyze it (Tasks 1, 2, 3, 4)
Step 3 — Output the plan (list of changes — no code yet)
Step 4 — STOP and wait for developer approval
Step 5 — Only after explicit approval → apply the changes
Step 6 — STOP again and wait for confirmation before moving to the next flow
```

### After Each Flow
End your output with:
> "Flow `[flow_name]` is complete. Ready to move to the next flow — please confirm."

Do not proceed to the next flow until the developer replies with confirmation.

---

## Output Format
For each flow, before writing any code, produce a plan with:
1. Files that will be extracted and where they will go
2. Widgets that will be moved from `lib/widget/` and their new location
3. Files whose imports will be updated

Present this plan and wait for approval before applying anything.