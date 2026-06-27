# Role & Objective
You are an expert Flutter/Dart engineer. Your task is to refactor the error handling mechanism across all Cubits in this project. You need to eliminate repetitive `_handleError` methods inside individual Cubits and replace them with a centralized, unified error handling system, without changing any existing business logic or state emission flow.

# Provided Context & Files
You are provided with two reference files:
1. `ERROR_CODES.md`: The backend contract detailing the error response envelope and codes.
2. `flutter_error_messages.dart`: Contains the `ApiError` class, localization mapping (`_errorMessages`), and the `resolveErrorMessage` logic already implemented by the backend team.

# Requirements

## 1. Create the Central Error Handler
Create a new file named `errorhandler.dart` inside the `lib/config/` directory.
- Move or import the `ApiError` class and `resolveErrorMessage` logic from `flutter_error_messages.dart` into this file (or structure it cleanly so it's globally accessible).
- Implement a global utility class or function (e.g., `CubitErrorHandler`) that accepts the dynamic error object and returns the appropriate user-facing message.
- **Error Resolution Logic:** - If the error can be parsed as an `ApiError` (using `ApiError.fromResponse`), use its `.message` getter to get the localized Persian string (including parameter interpolation like currency, percentages, etc., as implemented in `_fa`).
    - **Strict Fallback Rule:** If the error code is completely unknown, missing, or if the exception is a raw system/network error that cannot be parsed into an `ApiError`, you MUST strictly return the `genericFallback` string ('خطایی رخ داد. لطفاً دوباره تلاش کنید'). **Never** leak raw English error messages, the backend's `detail` field, or `error.toString()` to the end user.

## 2. Refactor All Cubits
Scan all Cubits in the project. For every Cubit:
- Locate the internal `void _handleError(...)` method.
- Remove this duplicated method entirely.
- Replace its invocation inside `try-catch` blocks with a call to the new centralized handler from `lib/config/errorhandler.dart`.
- **CRITICAL:** Do NOT modify the architecture of the Cubit states. If a Cubit emits a specific error state (e.g., `emit(LoginFailure(message: ...))`), ensure it still emits that exact state, but passes the user-facing error message resolved by the new central handler.

## 3. Preservation of Form Validation (400 Errors)
Ensure that for `validation_error` (HTTP 400), where `fieldErrors` are populated, the central handler still exposes or passes these field errors correctly so that Cubits handling form validations do not break.

# Output Expectations
1. Generate the exact code for `lib/config/errorhandler.dart`.
2. Provide a clean diff or example of how a modified Cubit looks before and after the refactoring.
3. Proceed to update all Cubits across the codebase accordingly.