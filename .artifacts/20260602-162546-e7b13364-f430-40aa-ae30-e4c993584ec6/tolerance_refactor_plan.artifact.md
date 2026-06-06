# Dynamic Tolerance Refactor Plan

## Current Implementation
- Tolerance value is hardcoded as `0.2` (20%) in `lib/ui/presenters/orders/bloc/orders_cubit.dart`.
- The user profile (`UserProfileDtoModel`) contains a `tolerance` field (double).
- User profile is fetched in `DashboardCubit` and stored in its state.

## Proposed Strategy
1.  **Centralize Constants**: Create `lib/config/app_constants.dart` to hold a default tolerance value (fallback if server value is null).
2.  **Shared State Access**: Since `OrdersCubit` needs the tolerance from `DashboardCubit`'s state:
    - **Option A**: Use `BlocListener` in `DashboardScreen` to update `OrdersCubit` when profile is loaded.
    - **Option B**: Add a `updateProfile` method to `OrdersCubit` and call it from `DashboardCubit`.
    - **Option C**: Use a global `GlobalConfig` or `AppProvider` to store the tolerance once fetched.

Given the existing architecture, I will use **Option B**:
- Update `OrdersState` to include `tolerance`.
- Add `updateTolerance(double? value)` to `OrdersCubit`.
- In `DashboardCubit`, after fetching the profile, notify `OrdersCubit`.

## Files to Modify
1.  **`lib/config/app_constants.dart`**: [NEW] Define `AppConstants.defaultTolerance = 0.2`.
2.  **`lib/ui/presenters/orders/bloc/orders_state.dart`**: Add `@Default(0.2) double tolerance`.
3.  **`lib/ui/presenters/orders/bloc/orders_cubit.dart`**:
    - Add `updateTolerance` method.
    - Replace `const tolerancePercent = 0.2` with `state.tolerance`.
4.  **`lib/ui/presenters/dashboard/bloc/dashboard_cubit.dart`**: After `emit(state.copyWith(userProfile: profile))`, call `sl<OrdersCubit>().updateTolerance(profile.tolerance)`.
    - *Correction*: `OrdersCubit` is provided via `BlocProvider` in `DashboardScreen`. I should pass it via the UI or use a stream.

Actually, a simpler way is to have `OrdersCubit` read the tolerance from the `UserProfileDtoModel` which can be passed to it when initializing or updated later.

### Final Plan:
1.  Create `lib/config/app_constants.dart`.
2.  Add `tolerance` to `OrdersState`.
3.  Implement `setTolerance` in `OrdersCubit`.
4.  In `MainView` (inside `DashboardScreen`), add a `BlocListener` for `DashboardCubit` that calls `context.read<OrdersCubit>().setTolerance(state.userProfile?.tolerance)`.
