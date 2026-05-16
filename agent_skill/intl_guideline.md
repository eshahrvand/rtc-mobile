# Engineering DNA: Localization & String Management

## 1. Rule
Every user-facing string in the project must be registered in the intl arb files.
**No hardcoded strings are allowed in UI files.**

---

## 2. ARB File Convention

### `intl_fa.arb` — Persian (primary language)
Always provide the full Persian value:
```json
{
  "confirmButton": "تایید",
  "@confirmButton": {},

  "searchHint": "جست‌وجو...",
  "@searchHint": {}
}
```

### `intl_en.arb` — English
Always leave the value as an **empty string** — never translate or guess:
```json
{
  "confirmButton": "",
  "@confirmButton": {},

  "searchHint": "",
  "@searchHint": {}
}
```

---

## 3. Key Naming Convention
- Format: `camelCase`
- Descriptive and specific to context
- Examples:

| Key | Persian value |
|---|---|
| `loginTitle` | عنوان صفحه ورود |
| `confirmButton` | تایید |
| `cancelButton` | انصراف |
| `searchHint` | جست‌وجو... |
| `errorGeneral` | خطایی رخ داده است |
| `recentOrdersHeader` | آخرین سفارش‌ها |

---

## 4. Reference in Code
Always use `S.current.keyName` — never `S.of(context).keyName`:

```dart
// ✅ Correct
Text(S.current.confirmButton)
hint: S.current.searchHint

// ❌ Wrong
Text('تایید')
Text(S.of(context).confirmButton)
```

---

## 5. Which Strings to Extract

### ✅ Always extract
- Text passed to `Text()` widgets
- Button labels
- TextField hints and labels
- AppBar titles
- Snackbar messages
- Dialog titles and content
- Tab labels
- Placeholder text
- Section headers

### ❌ Never extract
- Asset paths: `'assets/images/rtc_logo.svg'`
- Route paths: `'/home'`, `AppRoutes.x`
- Map keys or identifiers: `'productId'`, `'extra'`
- Strings already using `S.current.x`
- Log messages and debug strings

---

## 6. Workflow

```
Step 1 — Add key + Persian value to intl_fa.arb
Step 2 — Add same key with "" to intl_en.arb
Step 3 — Run: flutter pub run intl_utils:generate
Step 4 — Replace hardcoded string in Dart file with S.current.keyName
```

---

## 7. Example — Before & After

### Before
```dart
Text('اطلاعات مشتری')
RtcTextField(hint: 'کد ملی را وارد کنید')
```

### intl_fa.arb
```json
{
  "customerInfoTitle": "اطلاعات مشتری",
  "@customerInfoTitle": {},

  "nationalIdHint": "کد ملی را وارد کنید",
  "@nationalIdHint": {}
}
```

### intl_en.arb
```json
{
  "customerInfoTitle": "",
  "@customerInfoTitle": {},

  "nationalIdHint": "",
  "@nationalIdHint": {}
}
```

### After
```dart
Text(S.current.customerInfoTitle)
RtcTextField(hint: S.current.nationalIdHint)
```

---

## 8. Generate Command
After every change to arb files:
```bash
flutter pub run intl_utils:generate
```