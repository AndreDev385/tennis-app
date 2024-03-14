import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:tennis_app/main.dart';
import 'package:tennis_app/screens/app/cta/home.dart';
import 'package:tennis_app/services/player/add_device.dart';

Future<void> handleBackgroundMessage(RemoteMessage msg) async {
  await Firebase.initializeApp();

  navigationKey.currentState?.pushNamed(CtaHomePage.route);
}

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;

  final _androidChannel = const AndroidNotificationChannel(
    "high_importance_channel",
    "High Importance Notificaions",
    description: "This channel is used for important notifications",
    importance: Importance.defaultImportance,
  );

  final _localNotifications = FlutterLocalNotificationsPlugin();

  void handleMessage(RemoteMessage? msg) {
    if (msg == null) return;

    navigationKey.currentState?.pushNamed(CtaHomePage.route);
  }

  void onDidReceiveNotification(NotificationResponse res) async {
    final String? payload = res.payload;
    if (payload == null) {
      handleMessage(null);
      return;
    }
    handleMessage(RemoteMessage.fromMap(jsonDecode(payload)));
  }

  Future initLocalNotifications() async {
    const iOS = DarwinInitializationSettings();
    const android = AndroidInitializationSettings("@drawable/icon_home");
    const settings = InitializationSettings(android: android, iOS: iOS);

    await _localNotifications.initialize(
      settings,
      onDidReceiveNotificationResponse: onDidReceiveNotification,
    );

    final platform = _localNotifications.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();

    await platform?.createNotificationChannel(_androidChannel);
  }

  Future initPushNotifications() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
    FirebaseMessaging.onMessage.listen((RemoteMessage msg) {
      final notification = msg.notification;
      if (notification == null) return;

      _localNotifications.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            _androidChannel.id,
            _androidChannel.name,
            channelDescription: _androidChannel.description,
          ),
        ),
        payload: jsonEncode(msg.toMap()),
      );
    });
  }

  Future<void> initNotifications() async {
    _firebaseMessaging.requestPermission();
    final settings = await _firebaseMessaging.getNotificationSettings();
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      String? token = await _firebaseMessaging.getToken();

      if (token != null) {
        await addDevice(token);
        await initLocalNotifications();
        await initPushNotifications();
      }
    }
  }
}
