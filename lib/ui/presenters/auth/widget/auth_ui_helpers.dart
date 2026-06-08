import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../config/snackbar.dart';
import '../../../../generated/l10n.dart';
import '../../../router/app_route.dart';
import '../bloc/auth_state.dart';

class AuthUiHelpers {
  /// Handles side effects (navigation, snackbars) based on the AuthRequestStatus.
  static void handleStatusAction(BuildContext context, AuthState state) {
    switch (state.status) {
      case AuthRequestStatus.success:
        context.go(AppRoutes.dashboard);
      case AuthRequestStatus.error:
        rtcSnackBar(
          context: context,
          type: SnackBarType.error,
          message: state.errorMessage,
        );
      case AuthRequestStatus.otpResent:
        rtcSnackBar(
          context: context,
          type: SnackBarType.success,
          message: S.current.otpResent,
        );
      default:
        break;
    }
  }
}
