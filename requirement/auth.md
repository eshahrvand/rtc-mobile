# Feature Spec: Auth Screen

## 1. Overview
The Auth screen handles user authentication via phone number and OTP.
It is navigated to from the Splash screen when the user has no token or an invalid token.

---

## 2. User Flow

```
Splash (tokenNotValid)
    └── Auth Screen
            ├── State: getPhoneNumber
            │       └── user enters valid phone number
            │               └── tap confirm button
            │                       └── State: getOtp
            │
            └── State: getOtp
                    ├── user fills pinput → confirm button activates → submit OTP
                    ├── tap "ارسال مجدد" → resend OTP + reset countdown
                    ├── tap "ارسال به روبیکا" → send OTP via Rubika
                    └── tap edit button → back to State: getPhoneNumber
```

---

## 3. State Management Specification

### Cubit: `AuthCubit`
- Located at: `ui/presenters/auth/bloc/auth_cubit.dart`
- State file: `ui/presenters/auth/bloc/auth_state.dart`
- State built with **Freezed**

### Status Enum: `AuthStep`
```
AuthStep {
  getPhoneNumber,
  getOtp,
}
```

### State Fields
```
AuthState {
  AuthStep step,              // current step — default: getPhoneNumber
  String phoneNumber,         // entered phone number — default: ''
  String otp,                 // entered OTP — default: ''
  bool isPhoneValid,          // controls confirm button in getPhoneNumber — default: false
  bool isOtpComplete,         // controls confirm button in getOtp — default: false
  bool isLoading,             // loading state for API calls — default: false
  bool isTimerExpired,        // false = show timer, true = show resend buttons — default: false
  int remainingSeconds,       // countdown value in seconds — default: 120 (or as defined by backend)
  AuthRequestStatus status,   // for BlocListener side effects
  String errorMessage,        // default: ''
}
```

### Status Enum: `AuthRequestStatus`
```
AuthRequestStatus {
  initial,
  submitting,
  otpSent,
  otpResent,
  success,
  error,
}
```

### Cubit Methods
| Method | Description |
|---|---|
| `onPhoneChanged(String phone)` | validates phone number, emits `isPhoneValid` |
| `submitPhone()` | calls repository to request OTP, on success emits `step: getOtp` |
| `onOtpChanged(String otp)` | checks if pinput is complete, emits `isOtpComplete` |
| `submitOtp()` | calls repository to verify OTP |
| `resendOtp()` | calls repository to resend OTP, triggers countdown reset |
| `sendViaRubika()` | calls repository to send OTP via Rubika |
| `editPhoneNumber()` | emits `step: getPhoneNumber`, resets OTP fields |

### Future Handling Rule
- Every `Future` must use `.then().catchError()` — **no `try/catch`**

---

## 4. UI Structure

### Root Widget: `AuthScreen`
- Provides `BlocProvider<AuthCubit>`
- Contains `MultiBlocListener` for side effects
- Contains one `BlocBuilder<AuthCubit, AuthState>` that switches between child widgets based on `state.step`

```
AuthScreen
├── BlocProvider<AuthCubit>
├── MultiBlocListener        ← navigation + error snackbar
└── Scaffold
    └── BlocBuilder (switchs on state.step)
        ├── state.step == getPhoneNumber → PhoneNumberWidget
        └── state.step == getOtp        → OtpWidget
```

---

## 5. Child Widget: `PhoneNumberWidget`

### Source
Figma screenshot filename: `auth_phone.png` (place in `ui-figma/auth/`)

### Contents (replicate exactly from screenshot)
- Several text elements (titles/descriptions) — content from screenshot
- One text field for phone number input (`rtc_text_field` if available in `lib/widget/`)
- One confirm button at the bottom
    - **Disabled** when `state.isPhoneValid == false`
    - **Enabled** when `state.isPhoneValid == true`

### Interactions
| User Action | Cubit Call |
|---|---|
| types in text field | `context.read<AuthCubit>().onPhoneChanged(value)` |
| taps confirm button (when enabled) | `context.read<AuthCubit>().submitPhone()` |

---

## 6. Child Widget: `OtpWidget`

### Source
Figma screenshot filename: `auth_otp.png` (place in `ui-figma/auth/`)

### Contents (replicate exactly from screenshot)
- Several text elements (titles/descriptions) — content from screenshot
- One PinInput field (use an appropriate pin input package)
- A **conditional block** below the pinput — switches based on `state.isTimerExpired`:
    - `state.isTimerExpired == false` → show countdown timer only
    - `state.isTimerExpired == true` → show two `rtc_text_button` widgets:
        - `ارسال مجدد` — resend OTP
        - `ارسال به روبیکا` — send via Rubika
- One edit button (icon or text) that returns to phone number step
- One confirm button at the bottom
    - **Disabled** when `state.isOtpComplete == false`
    - **Enabled** when `state.isOtpComplete == true`

### Countdown Timer
- The countdown is managed **inside the Cubit** — not in the widget
- The widget reads the remaining seconds from `state.remainingSeconds` and displays it
- When `state.remainingSeconds` reaches zero, Cubit emits `isTimerExpired: true`
- Tapping `ارسال مجدد` calls `resendOtp()` which resets the countdown and emits `isTimerExpired: false`

### Interactions
| User Action | Cubit Call |
|---|---|
| fills pinput | `context.read<AuthCubit>().onOtpChanged(value)` |
| taps confirm (when enabled) | `context.read<AuthCubit>().submitOtp()` |
| taps ارسال مجدد | `context.read<AuthCubit>().resendOtp()` |
| taps ارسال به روبیکا | `context.read<AuthCubit>().sendViaRubika()` |
| taps edit button | `context.read<AuthCubit>().editPhoneNumber()` |

---

## 7. BlocListener Specification

Wrap the screen body in `MultiBlocListener`.
Use **plain `if/else`** with direct field comparison — **no `maybeWhen` or `when`**.

```
listenWhen: (prev, curr) => prev.status != curr.status

listener reactions:
  if status == success       → context.go(AppRoutes.home)
  if status == error         → show error snackbar with state.errorMessage
  if status == otpSent       → (handled by step change in BlocBuilder, no extra action needed)
  if status == otpResent     → show confirmation snackbar "کد مجدداً ارسال شد"
```

---

## 8. UI Rules

- **Theme, colors, and text styles** are added manually by the developer after implementation — use `TODO` placeholders
- **Replicate the screenshot exactly** — no extra elements, no layout changes
- Each child widget file must stay under **150–200 lines**
- No business logic inside any UI file
- Navigation only via **GoRouter** (`context.go(...)`) — never `Navigator.push`
- Use `rtc_` prefixed widgets from `lib/widget/` wherever a matching component exists

---

## 9. File Structure

```
ui/presenters/auth/
├── auth.dart                          # Root screen: BlocProvider + MultiBlocListener + BlocBuilder
├── bloc/
│   ├── auth_cubit.dart
│   └── auth_state.dart
└── widget/
    ├── phone_number_widget.dart       # UI for getPhoneNumber step
    └── otp_widget.dart               # UI for getOtp step
```

---

## 10. Figma Assets

Place screenshots in:
```
ui-figma/auth/
├── auth_phone.png     ← getPhoneNumber step UI
└── auth_otp.png       ← getOtp step UI
```

The AI agent must read both images before writing any code.

---

## 11. Cross-Reference
- **`state_management_guideline.md`**: `.then().catchError()`, BlocListener if/else, no maybeWhen
- **`routing_guideline.md`**: GoRouter only, navigation from BlocListener
- **`ui_component_system_guideline.md`**: 150–200 line limit, widget extraction rules
- **`ui_figma_implementation_guideline.md`**: screenshot replication rules, `lib/widget/` scan process
- **`Project_structure_schematic.md`**: auth folder structure and file naming conventions