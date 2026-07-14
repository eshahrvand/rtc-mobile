import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';

class AnalyticsService {
  AnalyticsService(this._analytics);
  final FirebaseAnalytics _analytics;

  FirebaseAnalyticsObserver get observer =>
      FirebaseAnalyticsObserver(analytics: _analytics);

  void logScreenView(String screenName) {
    _analytics
        .logScreenView(screenName: screenName)
        .then((_) => debugPrint('Analytics: Screen View - $screenName'))
        .catchError((e) => debugPrint('Analytics Error: Screen View - $e'));
  }

  void logButtonTap(String buttonName, {Map<String, Object>? params}) {
    _analytics.logEvent(
      name: 'button_tap',
      parameters: {
        'button_name': buttonName,
        if (params != null) ...params,
      },
    ).then((_) {
      debugPrint('Analytics: Button Tap - $buttonName ${params ?? ''}');
    }).catchError((e) {
      debugPrint('Analytics Error: Button Tap - $e');
    });
  }
}
