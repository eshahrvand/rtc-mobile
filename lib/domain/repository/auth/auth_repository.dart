

import '../../../data_source/local/prefs/prefs.dart';
import '../../../data_source/remote/auth/auth_service.dart';

class AuthRepository {
  final AuthService _authService;
  final Prefs _prefs;

  AuthRepository(this._authService, this._prefs);

  Future<void> requestOtp(String mobile) async {
    await _authService.requestOtp({'mobile': mobile});
  }

  Future<void> verifyOtp(String mobile, String otp) async {
    final tokens = await _authService.verifyOtp({
      'mobile': mobile,
      'otp': otp,
    });
    await _prefs.saveTokens(access: tokens.access, refresh: tokens.refresh);
  }
}
