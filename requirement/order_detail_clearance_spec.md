# Feature Spec: Order Detail — Financial Tab Clearance Flow

## 1. Overview
This spec covers the clearance and settlement flow inside the **Financial Info Tab** (`تب اطلاعات مالی`) of the Order Detail screen.

**Scope:** Only the case where clearance amount equals the order amount.
Other amount cases (greater/less) will be handled separately in future specs.

---

## 2. Flow Overview

```
Financial Info Tab
    └── user taps "تخلیه و تسویه" button
            └── ClearanceAmountSheet opens
                    └── user enters amount → taps "بررسی"
                            └── API call → returns gatewayType
                                    ├── gatewayType == online
                                    │       └── OtpClearanceSheet opens
                                    │               ├── user enters OTP → taps "تایید و تخلیه کارت"
                                    │               └── ClearanceSuccessSheet opens
                                    │                       └── user taps "متوجه شدم"
                                    │                               └── tab updates (clearanceStep: done)
                                    │
                                    └── gatewayType == offline
                                            └── ClearanceOperationSection appears in tab
                                                    └── user taps "بارگذاری مدارک تخلیه"
                                                            └── UploadDocumentsSheet opens
                                                                    └── user taps "تایید و ارسال"
                                                                            └── ClearanceSuccessSheet opens
                                                                                    └── tab updates (clearanceStep: uploaded)
```

---

## 3. State Changes in `OrderDetailCubit`

### New State Fields (add to existing `OrderDetailState`)
```dart
// Clearance flow
ClearanceStep clearanceStep,           // default: initial
GatewayType? gatewayType,              // null until API responds
String clearanceAmount,                // user input — default: ''

// OTP (online gateway)
String otpCode,                        // default: ''
int otpRemainingSeconds,               // default: 60
bool isOtpTimerExpired,                // default: false
bool isOtpComplete,                    // default: false

// Documents (offline gateway)
List<ClearanceDocumentModel> uploadedDocuments,  // default: []

// TODO: image viewer — to be defined
// TODO: document upload limit — to be defined
```

### New Enums

```dart
enum ClearanceStep {
  initial,           // button visible, no clearance started
  amountEntered,     // amount submitted, waiting for gateway type
  otpPending,        // online: OTP sheet open
  documentsPending,  // offline: upload section visible
  done,              // online: clearance complete
  uploaded,          // offline: documents uploaded
}

enum GatewayType {
  online,
  offline,
}
```

### New Cubit Methods
| Method | Description |
|---|---|
| `onClearanceAmountChanged(String value)` | emits `clearanceAmount` |
| `checkClearanceAmount()` | calls repository → determines `gatewayType` → emits `clearanceStep: otpPending` or `documentsPending` |
| `onOtpChanged(String value)` | emits `otpCode`, checks if complete → emits `isOtpComplete` |
| `resendOtp()` | API call → resets `otpRemainingSeconds: 60`, `isOtpTimerExpired: false` |
| `verifyClearanceOtp()` | API call → on success emits `clearanceStep: done` |
| `pickClearanceDocument()` | opens gallery → adds to `uploadedDocuments` |
| `removeDocument(String id)` | removes from `uploadedDocuments` |
| `submitOfflineClearance()` | API call to upload documents → on success emits `clearanceStep: uploaded` |
| `editClearanceAmount()` | resets to `clearanceStep: initial`, clears `clearanceAmount` |

### Future Handling Rule
Every `Future` uses `.then().catchError()` — **no `try/catch`**

### Hardcoded Gateway (for testing)
Until the real API is connected, hardcode `gatewayType` inside `checkClearanceAmount()`:
```dart
// TODO: replace with real API response
emit(state.copyWith(gatewayType: GatewayType.online)); // or offline
```

---

## 4. Data Models

### `ClearanceDocumentModel`
```dart
class ClearanceDocumentModel {
  final String id;
  final String name;
  final String size;       // display string e.g. "۲.۳ MB"
  final String filePath;
}
```

---

## 5. UI — Financial Info Tab Updates

The existing tab body gets two conditional sections driven by `state.clearanceStep`:

```dart
// inside financial tab body
Column(
  children: [
    // existing financial summary section (collapsible — unchanged)

    // clearance button — visible only when clearanceStep == initial
    if (state.clearanceStep == ClearanceStep.initial)
      RtcClearanceButton(onTap: () => cubit.showClearanceAmountSheet()),

    // clearance operation section — visible after offline amount is submitted
    if (state.clearanceStep == ClearanceStep.documentsPending ||
        state.clearanceStep == ClearanceStep.uploaded)
      RtcClearanceOperationSection(
        amount: state.clearanceAmount,
        step: state.clearanceStep,
        onEdit: () => cubit.editClearanceAmount(),
        onUpload: () => cubit.showUploadDocumentsSheet(),
      ),
  ],
)
```

---

## 6. BlocListener — Sheet Triggers

Add to `OrderDetailScreen`'s `MultiBlocListener`:

```dart
BlocListener<OrderDetailCubit, OrderDetailState>(
  listenWhen: (prev, curr) => prev.clearanceStep != curr.clearanceStep,
  listener: (context, state) {
    if (state.clearanceStep == ClearanceStep.initial) {
      // show ClearanceAmountSheet
    }
    if (state.clearanceStep == ClearanceStep.otpPending) {
      // show OtpClearanceSheet
    }
    if (state.clearanceStep == ClearanceStep.done ||
        state.clearanceStep == ClearanceStep.uploaded) {
      // show ClearanceSuccessSheet
    }
  },
),
```

**No `maybeWhen`, `when`, `map`, or `maybeMap`.**

---

## 7. New Components

### `RtcClearanceAmountSheet`
**File:** `lib/widget/rtc_clearance_amount_sheet.dart`

Layout (from `online_gateway/` and `offline_gateway/` screenshots — amount input step):
- Title: "مبلغ تخلیه کارت را وارد کنید"
- Display of final invoice amount
- Numeric input field (pre-filled with order amount)
- Custom numeric keypad
- "بررسی" button

Interactions:
- Keypad input → `cubit.onClearanceAmountChanged(value)`
- "بررسی" tap → `cubit.checkClearanceAmount()`

---

### `RtcOtpClearanceSheet`
**File:** `lib/widget/rtc_otp_clearance_sheet.dart`

Layout (from `online_gateway/` OTP screenshots):
- Title: "تخلیه کارت اعتباری"
- Masked phone number label
- 5 OTP input boxes
- Timer display (reads `state.otpRemainingSeconds`)
    - Timer active → shows countdown
    - Timer expired (`state.isOtpTimerExpired == true`) → shows "ارسال مجدد" link
- "انصراف" button
- "تایید و تخلیه کارت" button
    - Disabled when `state.isOtpComplete == false`
    - Enabled when `state.isOtpComplete == true`

Interactions:
- OTP input → `cubit.onOtpChanged(value)`
- "ارسال مجدد" tap → `cubit.resendOtp()`
- "تایید" tap → `cubit.verifyClearanceOtp()`
- "انصراف" tap → close sheet

**Timer logic lives in Cubit** — not in this widget.

---

### `RtcClearanceOperationSection`
**File:** `lib/widget/rtc_clearance_operation_section.dart`

Layout (from `offline_gateway/` screenshots — section inside tab):
- Section header with edit icon
- Clearance amount displayed in a gray box
- Descriptive text
- "بارگذاری مدارک تخلیه" button (visible when `step == documentsPending`)
- Green "بارگذاری شده" badge (visible when `step == uploaded`)

Constructor:
```dart
RtcClearanceOperationSection({
  required String amount,
  required ClearanceStep step,
  required VoidCallback onEdit,
  required VoidCallback onUpload,
})
```

---

### `RtcUploadDocumentsSheet`
**File:** `lib/widget/rtc_upload_documents_sheet.dart`

Layout (from `offline_gateway/` upload screenshots):
- Title: "بارگذاری مدارک"
- Instructional text
- List of `ClearanceDocumentModel` items — each shows:
    - File name
    - File size
    - Delete icon → `cubit.removeDocument(id)`
    - Eye/view icon → `// TODO: image viewer`
- "انصراف" button → close sheet
- "تایید و ارسال" button → `cubit.submitOfflineClearance()`

---

### `RtcClearanceSuccessSheet`
**File:** `lib/widget/rtc_clearance_success_sheet.dart`

Layout (shared between online and offline — success screenshots):
- Large green checkmark icon
- Title (different per gateway type):
    - Online: "تخلیه با موفقیت انجام شد"
    - Offline: "مستندات تخلیه با موفقیت ارسال شد"
- Key-value list of transaction details
- "متوجه شدم" button → close sheet

Constructor:
```dart
RtcClearanceSuccessSheet({
  required GatewayType gatewayType,
  required Map<String, String> details,
})
```

---

## 8. UI Rules

- Replicate all screenshots **exactly** — no extra elements, no layout changes
- All logic lives in `OrderDetailCubit`
- No `Future`, `async`, `await` in UI files
- No local `setState` — all state via Cubit
- All colors → `// TODO: replace with theme values`
- All icons → SVG via `rtc_image`
- Every file under **150–200 lines** — extract if exceeded
- Navigation via **GoRouter only**
- RTL direction — do not add or change any `Directionality`, `TextDirection`, or alignment values

---

## 9. File Structure

```
lib/widget/
├── rtc_clearance_amount_sheet.dart
├── rtc_otp_clearance_sheet.dart
├── rtc_clearance_operation_section.dart
├── rtc_upload_documents_sheet.dart
└── rtc_clearance_success_sheet.dart

ui/presenters/order_detail/
├── order_detail.dart              ← add new BlocListeners here
├── bloc/
│   ├── order_detail_cubit.dart   ← add new methods + state fields
│   └── order_detail_state.dart   ← add new fields + enums
└── widget/
    └── order_detail_tab2.dart    ← add clearance button + operation section
```

---

## 10. Figma Assets

```
ui-figma/order_detail/online_gateway/    ← all online flow screenshots
ui-figma/order_detail/offline_gateway/   ← all offline flow screenshots
```

Read all screenshots before writing any code.

---

## 11. Open TODOs
- Image viewer for uploaded documents — to be defined
- Document upload limit — to be defined
- Other amount cases (greater/less than order amount) — separate spec

---

## 12. Cross-Reference
- **`orders_screen_spec.md`**: existing Order Detail structure and tab layout
- **`state_management_guideline.md`**: `.then().catchError()`, BlocListener if/else
- **`auth_screen_spec.md`**: OTP + countdown timer pattern inside Cubit
- **`pre_invoice_screen_spec.md`**: document upload pattern (`pickDoc`, `removeDoc`)
- **`project_context_summary.md`**: full project rules