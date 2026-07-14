# Firebase Integration: Analytics + Push Notifications (FCM)

## Context
This is `rtc_mobile`, a Flutter app targeting Android, iOS, and Web, built with Clean Architecture + Cubit/Freezed.
Firebase project registration is already done. `google-services.json` (Android) has already been obtained and placed appropriately. Do NOT assume iOS `GoogleService-Info.plist` or Web Firebase config exist yet — check first, and ask if missing rather than inventing placeholder values.

## MANDATORY: Investigate first
Before writing any code:
1. Check `pubspec.yaml` for any existing `firebase_*` dependencies.
2. Check `android/app/build.gradle(.kts)` and project-level `build.gradle(.kts)` for existing Google services plugin setup.
3. Check `ios/Runner` for existing Firebase config or Podfile entries.
4. Check `web/index.html` and `web/` folder for any existing Firebase JS SDK references or self-hosted scripts (this project has had a prior effort to self-host Firebase JS SDK for network isolation — do not overwrite that, extend it if it exists).
5. Report what you find before proceeding. Do not modify unrelated files.

## Scope — do these ONE AT A TIME, in this order, with my approval between each:

### Step 1: Firebase Core setup (all platforms)
- Add `firebase_core` to `pubspec.yaml`.
- Initialize Firebase in `main.dart` using `Firebase.initializeApp()` — this specific call must remain `async/await` (Firebase init is an established exception to the no-async/await rule), but do NOT introduce async/await anywhere else in the codebase.
- Android: wire up `google-services.json` and the Google Services Gradle plugin correctly.
- iOS: tell me exactly what file I need to provide (`GoogleService-Info.plist`) and where it goes — do not fabricate one.
- Web: use `FirebaseOptions` initialized directly in Dart (not loaded via JS `<script>` from Google's CDN/gstatic). If a self-hosted Firebase JS SDK setup already exists in `web/`, integrate with it; do NOT add a `<script src="https://www.gstatic.com/...">` tag, since this project requires full network isolation on Web.

### Step 2: Firebase Analytics
- Add `firebase_analytics` to `pubspec.yaml`.
- Create a single service/wrapper class (follow existing project service conventions — check `lib/` for where similar services like `MediaService` live) that exposes methods for:
    - Logging screen views
    - Logging button/tap events
- Use `.then().catchError()` for any Future-returning Analytics calls — no async/await here.
- Do NOT wire this into every screen yet. Just build the wrapper and show me one working example (e.g. one screen view log + one button tap log) so I can approve the pattern before we tag the rest of the app.

### Step 3: Push Notifications (FCM) — Android, iOS, and Web

I'm providing a reference implementation below from a DIFFERENT app (`axino`) purely to show the pattern/structure I like for the notification service. Do NOT copy it verbatim:
- Ignore its imports (`axino/locator.dart`, `notification_repository.dart`, etc.) — this project's DI, repository pattern, and file structure are different. Investigate `rtc_mobile`'s actual structure first (locator/service locator setup, existing service classes) and follow that instead.
- Ignore the `dart:io if (dart.library.html) dart:html` conditional import — check if this project already has a preferred platform-detection pattern instead of reintroducing this one.
- This project does NOT use bare `async/await` except for the established Firebase-init exception — convert this reference's `await` chains to `.then().catchError()` wherever it isn't Firebase SDK initialization itself.

REFERENCE CODE (pattern only, not to be copied as-is):

```dart
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _localNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static const AndroidNotificationChannel _channel = AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    description: 'This channel is used for important notifications.',
    importance: Importance.max,
    playSound: true,
  );

  Future<void> init() async {
    await _requestNotificationPermission();
    if (!kIsWeb) {
      await _initLocalNotifications();
    }
    await _initFCMListeners();
  }

  Future<void> _requestNotificationPermission() async {
    await _firebaseMessaging.requestPermission(alert: true, badge: true, sound: true);
  }

  Future<void> _initLocalNotifications() async {
    const initSettings = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: DarwinInitializationSettings(),
    );
    await _localNotificationsPlugin.initialize(initSettings);
    await _localNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(_channel);
  }

  Future<void> _initFCMListeners() async {
    FirebaseMessaging.onMessage.listen(_handleForegroundNotification);
    FirebaseMessaging.onMessageOpenedApp.listen((message) { /* ... */ });
    final initialMessage = await _firebaseMessaging.getInitialMessage();
    if (initialMessage != null) { /* app launched from terminated state */ }
  }

  void _handleForegroundNotification(RemoteMessage message) {
    if (!kIsWeb) {
      final notification = message.notification;
      final android = message.notification?.android;
      if (notification != null && android != null) {
        _localNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              _channel.id,
              _channel.name,
              channelDescription: _channel.description,
              icon: android.smallIcon ?? '@mipmap/ic_launcher',
              importance: Importance.max,
              priority: Priority.high,
              playSound: true,
            ),
          ),
        );
      }
    }
  }
}
```

REQUIRED CHANGES vs the reference above — build full three-platform support:

1. **Android**: Keep the `flutter_local_notifications` + `AndroidNotificationChannel` pattern for foreground notifications — this part of the reference is fine to adapt.

2. **iOS**: The reference initializes `DarwinInitializationSettings()` but never actually SHOWS a local notification on iOS in `_handleForegroundNotification` (it's gated behind `if (!kIsWeb)` combined with `android != null`, which silently skips iOS too, since `message.notification?.android` is null on iOS). Fix this: iOS foreground notifications must be handled properly — either via `flutter_local_notifications`'s iOS presentation options or via `FirebaseMessaging`'s native iOS foreground presentation options (`setForegroundNotificationPresentationOptions`). Show me the correct approach for this project rather than leaving iOS silently broken like the reference does.

3. **Web**: The reference does NOTHING for web foreground notifications. I want actual Web support:
    - Set up `firebase-messaging-sw.js` service worker for background/terminated-state push on Web (respecting this project's network-isolation/self-hosted Firebase JS SDK setup — do not pull the messaging SDK from gstatic CDN inside the service worker either; check how the existing self-hosted setup handles this and mirror it).
    - For foreground messages on Web, since `flutter_local_notifications` doesn't support Web, use the browser's native `Notification` API (via `dart:html` or the project's existing platform-conditional pattern) to display a notification when `FirebaseMessaging.onMessage` fires while the tab is active.
    - Handle Web notification permission request correctly (`requestPermission` behaves differently on web — confirm it prompts the browser's native permission dialog).

4. Replace all `print()` calls in the reference with whatever logging convention this project actually uses — check for an existing logger before adding `print()` statements.

5. Wrap this in a single service class following this project's actual service/DI conventions (found in Step 1's investigation) — not the reference's `locator()`/`INotificationRepository` structure unless this project already uses that same pattern.

6. As before: do not touch GoRouter, do not rename `rtc_`-prefixed widgets, do not run build_runner, use `.then().catchError()` instead of async/await except where Firebase requires it.

## General rules
- Minimal diff. No unrelated file changes.
- No UseCase layer — if a Cubit needs Analytics/Messaging, it calls the service directly.
- If you hit a decision point not covered above (e.g. where exactly to place the service class, or naming), ask me rather than guessing.
- After each step, stop and wait for my review/approval before moving to the next step.