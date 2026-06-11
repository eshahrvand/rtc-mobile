import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../../generated/l10n.dart';

class NetworkHelper {
  NetworkHelper._();

  /// Checks internet connectivity and VPN status.
  /// Returns a localized error message if an issue is detected, otherwise returns [null].
  static Future<String?> getNetworkErrorMessage({bool checkVpn = true}) async {
    bool hasConnection = false;

    // 1. Try connectivity_plus plugin
    try {
      final List<ConnectivityResult> connectivityResult = await Connectivity()
          .checkConnectivity();
      hasConnection = !connectivityResult.contains(ConnectivityResult.none);
    } catch (_) {
      // Fallback if plugin fails
      try {
        final interfaces = await NetworkInterface.list();
        hasConnection = interfaces.any((i) => i.addresses.isNotEmpty);
      } catch (_) {
        hasConnection = false;
      }
    }

    // 2. Reachability check
    if (hasConnection) {
      try {
        final result = await InternetAddress.lookup(
          'google.com',
        ).timeout(const Duration(seconds: 3));
        hasConnection = result.isNotEmpty && result[0].rawAddress.isNotEmpty;
      } catch (_) {
        hasConnection = false;
      }
    }

    if (!hasConnection) {
      return S.current.internetError;
    }

    return null;
  }
}
