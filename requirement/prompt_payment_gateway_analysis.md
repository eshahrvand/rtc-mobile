# Prompt: Analyze Payment Gateway Flow — Analysis Only (No Code)

## Context
This is a sub-case inside the **Order Detail — Financial Info Tab** (`تب اطلاعات مالی`).

The case being analyzed:
> Clearance amount (`مبلغ تخلیه`) equals the order amount (`مبلغ سفارش`)

This case has two sub-flows depending on the payment gateway type returned by the server:
- **Online gateway** (`درگاه آنلاین`) → screenshots in `ui-figma/order_detail/online_gateway/`
- **Offline gateway** (`درگاه آفلاین`) → screenshots in `ui-figma/order_detail/offline_gateway/`

---

## Your Task
Read all screenshots carefully and produce a **detailed written analysis only**.

**Do not write any code. Do not suggest any implementation. Analysis only.**

---

## What To Produce

### 1. Online Gateway Flow (`online_gateway/` folder)
Go through every screenshot in order and describe:
- What the user sees on each screen/state
- What UI elements are present (buttons, fields, dialogs, bottom sheets, etc.)
- What action triggers the transition to the next screen/state
- Any conditional logic visible in the UI (e.g. enabled/disabled states, error states)

### 2. Offline Gateway Flow (`offline_gateway/` folder)
Same as above — describe each screen/state step by step.

### 3. Shared Elements
List any UI elements that appear in both flows that could be reused.

### 4. New UI Components Needed
List every new visual component visible in the screenshots that does not currently exist in `lib/widget/`.
For each:
- Describe what it looks like
- Describe what data it displays

### 5. State & Logic Summary
Describe (in plain language, no code):
- What new state fields would be needed in `OrderDetailState`
- What new status values would be needed
- What new Cubit methods would be needed
- What API calls appear to be involved

### 6. Questions & Ambiguities
List anything unclear that needs confirmation from the developer before implementation.

---

## Rules
- Do not write any Dart code
- Do not suggest file names or class names yet
- Reference screenshot file names when describing UI (e.g. "in `step3.png`, a bottom sheet appears...")
- Be as detailed and specific as possible
- Describe the UI exactly as it appears — do not assume or invent behavior