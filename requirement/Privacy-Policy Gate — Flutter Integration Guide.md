# Privacy-Policy Gate — Flutter Integration Guide

Nov 3, 2026 · @Shawn

## Overview

Once a privacy-policy version is published, the API locks agents until they accept it and locks their sales persons until the agent does. The app only reacts to what the backend says. It never compares versions itself.

- **Who is affected:** the Agent and Sales Person roles. Staff are never blocked.
- **When:** only after login. Login itself (`otp/request`, `otp/verify`) is never blocked.
- **Nothing published:** nobody is blocked.
- **Reference implementation:** the Angular panel, `web/src/app/core/policy/policy-gate.service.ts` and `web/src/app/layout/shell/`.

## Signals from the backend

Two signals tell the app the gate is closed: `policy_status` on `/me`, and a 403 with a gate code on any other request.

### 1. `GET /api/v1/accounts/me` → `policy_status`

Agent and sales-person users get this field. Staff don't.

```json
"policy_status": {
  "version": 3,
  "accepted_version": 2,
  "accepted_at": "2026-10-01T09:12:00+03:30",
  "required": true
}
```

| Field | Type | Meaning |
| --- | --- | --- |
| `version` | int | Latest published version |
| `accepted_version` | int or null | The version the (acting) agent last accepted |
| `accepted_at` | ISO datetime or null | When they accepted it |
| `required` | bool | `true` = the app is locked. **The only field to decide on** |

- `policy_status` is `null` while nothing has been published. Treat that as unlocked.
- A sales person gets their **agent's** acceptance, not their own.

### 2. 403 on any request

The error envelope is the usual one: `{"error": {"status_code": 403, "code": "…", "params": {"version": 3}, "detail": "…"}}`.

| `code` | Who gets it | Show |
| --- | --- | --- |
| `policy_acceptance_required` | Agent | Accept screen |
| `agent_policy_pending` | Sales person | Waiting screen |

This catches a version published while the user is already logged in: `/me` was fine at startup, and the next request hits the gate.

### Routes that stay open while locked

- `GET /accounts/me`
- `GET /content/privacy-policies/current`
- `POST /content/privacy-policies/current/accept`
- `GET /content/privacy-policies/<id>/document`

Every other authenticated request returns the 403.

## Gate state

Keep one app-wide gate state with three values: `ok`, `mustAccept` (agent) and `agentPending` (sales person). It is worked out from the current `/me` user plus a "block" raised by a 403.

```dart
enum PolicyGate { ok, mustAccept, agentPending }

const _gateCodes = {'policy_acceptance_required', 'agent_policy_pending'};

/// App-wide gate. Assumes an AuthCubit whose state.user is the latest /me —
/// rename to match the app.
class PolicyGateCubit extends Cubit<PolicyGate> {
  PolicyGateCubit(this._auth) : super(PolicyGate.ok) {
    // A new /me object clears any 403 block; policy_status decides again.
    _sub = _auth.stream
        .distinct((a, b) => identical(a.user, b.user))
        .listen((_) {
      _blockCode = null;
      _recompute();
    });
    _recompute();
  }

  final AuthCubit _auth;
  late final StreamSubscription _sub;
  String? _blockCode;

  /// Called by the Dio interceptor on a 403 gate code.
  void block(String code) {
    _blockCode = code;
    _recompute();
  }

  /// After a successful accept, or «بررسی مجدد»: reload /me.
  Future<void> recheck() => _auth.loadMe();

  void _recompute() {
    final me = _auth.state.user;
    final PolicyGate next;
    if (me == null || me.isStaff) {
      next = PolicyGate.ok;
    } else if (_blockCode != null) {
      next = _blockCode == 'policy_acceptance_required'
          ? PolicyGate.mustAccept
          : PolicyGate.agentPending;
    } else if (me.policyStatus?.required != true) {
      next = PolicyGate.ok;
    } else {
      next = me.role == UserRole.agent
          ? PolicyGate.mustAccept
          : PolicyGate.agentPending;
    }
    emit(next);
  }

  @override
  Future<void> close() {
    _sub.cancel();
    return super.close();
  }
}
```

The Dio interceptor raises the block and marks the error so the generic snackbar skips it:

```dart
class PolicyGateInterceptor extends Interceptor {
  PolicyGateInterceptor(this._gate);
  final PolicyGateCubit _gate;

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final data = err.response?.data;
    final code = data is Map ? data['error']?['code'] : null;
    if (err.response?.statusCode == 403 && _gateCodes.contains(code)) {
      _gate.block(code as String);
      err.requestOptions.extra['policyGated'] = true; // no snackbar
    }
    handler.next(err);
  }
}
```

The root widget switches on the state, so the normal screens are unmounted while locked and rebuilt fresh when the gate opens:

```dart
BlocBuilder<PolicyGateCubit, PolicyGate>(
  builder: (context, gate) => switch (gate) {
    PolicyGate.ok => const HomeShell(),
    PolicyGate.mustAccept => const PolicyAcceptScreen(),
    PolicyGate.agentPending => const PolicyPendingScreen(),
  },
)
```

- **Raising a block:** `PolicyGateInterceptor` calls `block(code)` on a 403 gate code.
- **Clearing a block:** `recheck()` reloads `/me`. The new user object clears the block, and `policy_status.required` decides again. This matches the web panel, where a block is tied to the `/me` object it was raised against.
- **Locked** = any state other than `ok`.
- Accept and pending screens can keep their own small cubits (loading the policy, the checkbox, the accept request). On success they call `context.read<PolicyGateCubit>().recheck()`.

&#91;embedded content: gate state · 2 inputs, 3 states\]

Both locked states end the same way: the user acts, the app reloads `/me`, and the gate is worked out again.

## Endpoints

All paths are under `/api/v1/content/privacy-policies`. Fields are snake\_case.

| Method + path | Who | Returns | Errors |
| --- | --- | --- | --- |
| `GET /current` | Agent, sales person | The latest published version (shape below) | 404 while nothing is published |
| `POST /current/accept` body `{"version": 3}` | Agent only | The same shape, with `accepted_at` set | 422 `policy_version_outdated`, `params.version` = the new latest |
| `GET /<id>/document` | Agent, sales person | Self-contained printable HTML | — |

`current` response:

```json
{
  "id": "uuid",
  "version": 3,
  "clauses": [{"title": "…", "body": "markdown…"}],
  "published_at": "2026-11-01T10:00:00+03:30",
  "accepted_at": null
}
```

- `clauses` is an ordered list. Each `body` is markdown, so render it with a markdown widget.
- `accepted_at` is the acting agent's acceptance of **this** version. A sales person sees their agent's.
- Always send back the `version` you showed. If a newer one was published meanwhile, accept returns 422 so the agent never accepts text they didn't see.
- `/document` returns the same kind of HTML as the order pre-invoice, so reuse that PDF/print path.

## UI flows

While the gate is locked, show one full-screen blocking screen and keep every other screen unmounted. The web panel removes its router outlet for the same reason: no page underneath keeps firing requests that all return 403.

- The screen can't be dismissed. Use `PopScope(canPop: false)` and no close button.
- When the gate opens again, rebuild the normal screens so they fetch fresh data.

### Agent — accept screen (`mustAccept`)

Web reference: `policy-accept-dialog.component.ts` (Figma 24088:155065).

1. Each time the screen opens, call `GET /current`, because a newer version may exist. Show a loader until it returns.
2. Show:
   - Title: «به‌روزرسانی قوانین و مقررات»
   - Badge: «نسخه {version} - {Jalali month of published\_at}»
   - Intro text with the Jalali `published_at` date
   - The clauses (title + markdown body) in a scrollable box
   - Checkbox: «نسخه جدید قوانین و مقررات را مطالعه کردم و می‌پذیرم.», unticked each time the screen opens
3. The accept button «تایید نسخه جدید قوانین و مقررات» stays disabled until the policy has loaded and the box is ticked. Show a loader while the request runs.
4. On tap, `POST /current/accept` with `{"version": shownVersion}`.
5. On success, reload `/me` and clear the block. `required` is now `false`, so the gate opens.
6. On 422 `policy_version_outdated`, show the error message and call `GET /current` again so the agent reads the new text.
7. Secondary button «دانلود فایل» opens `/<id>/document` as a PDF or print.

### Sales person — waiting screen (`agentPending`)

Web reference: `policy-pending-dialog.component.ts` (Figma 24088:204247). No API call is needed to show it.

- Title: «در انتظار تایید قوانین جدید», with an hourglass icon
- Body: «قوانین و مقررات سامانه به‌روزرسانی شده است. برای ادامه استفاده از پنل، ابتدا مدیر نمایندگی باید نسخه جدید قوانین را از طریق حساب کاربری خود تایید کند. لطفاً موضوع را به مدیر خود اطلاع دهید و پس از تایید ایشان، روی دکمه بررسی مجدد کلیک کنید.»
- «بررسی مجدد» (re-check): reload `/me` with a loader on the button and clear the block. If the agent has accepted, the gate opens. Otherwise the screen stays.
- «خروج» (log out): the normal logout.

### Read-only page «قوانین و مقررات»

A menu item for both agents and sales persons. Web reference: `policy-current.component.ts` (Figma 24088:215945).

- `GET /current`, then show the clauses plus an «اطلاعات قرارداد» card with «تاریخ انتشار:» (`published_at`) and «تاریخ تایید:» (`accepted_at`).
- On 404, show an empty state: «هنوز قوانین و مقرراتی منتشر نشده است».

## Implementation checklist

- [ ] Add `policy_status` (nullable) to the `/me` user model
- [ ] Add the global gate state from **Gate state** (a PolicyGateCubit, the Bloc pattern the app already uses)
- [ ] HTTP interceptor: on 403 with a gate code, raise the block and **skip the generic error snackbar**
- [ ] Root widget: while locked, show only the blocking screen; when it opens, rebuild the normal screens
- [ ] Agent accept screen, including the 422 `policy_version_outdated` reload
- [ ] Sales-person waiting screen with re-check and log out
- [ ] Read-only «قوانین و مقررات» page in the menu
- [ ] Reload `/me` at app start and when the app returns to the foreground
- [ ] Download/print via `/<id>/document`, reusing the pre-invoice code
- [ ] Add the error strings below to the error-code map

### Edge cases

- **Published mid-session:** the next request returns 403. The interceptor raises the block and the screen appears. Requests already in flight can fail too; they just stay hidden behind the screen.
- **Staff are never gated:** never show the gate for staff roles, even if a 403 code somehow arrives.
- **Token refresh** is not affected by the gate. A 401 still goes through the normal refresh flow.

### Error strings

Copied from `web/src/app/core/http/error-messages.ts`.

| Code | Status | Message |
| --- | --- | --- |
| `policy_acceptance_required` | 403 | برای ادامه، نسخه جدید قوانین و مقررات را تایید کنید |
| `agent_policy_pending` | 403 | مدیر نمایندگی هنوز نسخه جدید قوانین و مقررات را تایید نکرده است |
| `policy_version_outdated` | 422 | نسخه جدیدتری از قوانین و مقررات منتشر شده است؛ صفحه را دوباره بارگذاری کنید |

The two 403 messages are fallbacks only. Normally these codes open the blocking screen instead of a message. Full list: `docs/ERROR_CODES.md`.
