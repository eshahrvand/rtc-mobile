import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  debugPrint('Handling a background message: ${message.messageId}');
}

class NotificationService {
  NotificationService(this._firebaseMessaging, this._localNotificationsPlugin);

  final FirebaseMessaging _firebaseMessaging;
  final FlutterLocalNotificationsPlugin _localNotificationsPlugin;

  static const AndroidNotificationChannel _channel = AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    description: 'This channel is used for important notifications.',
    importance: Importance.max,
    playSound: true,
  );

  void init() {
    _requestNotificationPermission();
    // _printFcmToken();
    if (!kIsWeb) {
      _initLocalNotifications();
    }
    _initFCMListeners();
  }

  void _requestNotificationPermission() {
    _firebaseMessaging
        .requestPermission(alert: true, badge: true, sound: true)
        .then((settings) {
          debugPrint(
            'User granted permission: ${settings.authorizationStatus}',
          );
        })
        .catchError((e) {
          debugPrint('Error requesting notification permission: $e');
        });
  }

  void _printFcmToken() {
    _firebaseMessaging
        .getToken()
        .then((token) {
          debugPrint('>>fcm_token: $token');
        })
        .catchError((e) {
          debugPrint('Error getting FCM token: $e');
        });
  }

  void _initLocalNotifications() {
    const initSettings = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/launcher_icon'),
      iOS: DarwinInitializationSettings(),
    );
    _localNotificationsPlugin
        .initialize(settings: initSettings)
        .then((_) {
          _localNotificationsPlugin
              .resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin
              >()
              ?.createNotificationChannel(_channel)
              .then((_) => debugPrint('Android Notification Channel Created'))
              .catchError(
                (e) => debugPrint('Error creating Android channel: $e'),
              );
        })
        .catchError((e) {
          debugPrint('Error initializing local notifications: $e');
        });
  }

  void _initFCMListeners() {
    _firebaseMessaging
        .setForegroundNotificationPresentationOptions(
          alert: true,
          badge: true,
          sound: true,
        )
        .then((_) => debugPrint('iOS foreground notification options set'))
        .catchError(
          (e) => debugPrint('Error setting iOS foreground options: $e'),
        );

    FirebaseMessaging.onMessage.listen(_handleForegroundNotification);
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      debugPrint('Notification opened app: ${message.messageId}');
    });

    _firebaseMessaging
        .getInitialMessage()
        .then((message) {
          if (message != null) {
            debugPrint('App launched from terminated state via notification');
          }
        })
        .catchError((e) {
          debugPrint('Error getting initial message: $e');
        });

    if (!kIsWeb) {
      FirebaseMessaging.onBackgroundMessage(
        _firebaseMessagingBackgroundHandler,
      );
    }
  }

  void _handleForegroundNotification(RemoteMessage message) {
    debugPrint('Foreground Message Received: ${message.notification?.title}');

    final notification = message.notification;
    final android = message.notification?.android;

    if (notification != null) {
      _localNotificationsPlugin.show(
        id: notification.hashCode,
        title: notification.title,
        body: notification.body,
        notificationDetails: NotificationDetails(
          android: AndroidNotificationDetails(
            _channel.id,
            _channel.name,
            channelDescription: _channel.description,
            icon: android?.smallIcon ?? '@mipmap/launcher_icon',
            importance: Importance.max,
            priority: Priority.high,
            playSound: true,
          ),
          iOS: const DarwinNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
          ),
        ),
      );
    }
  }
}
