import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin
      _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static const NotificationDetails _notificationDetails = NotificationDetails(
    android: AndroidNotificationDetails(
      'neosurge',
      'neosurge_channel',
      channelDescription: 'neosurge channel',
      importance: Importance.high,
      priority: Priority.high,
      channelShowBadge: true,
    ),
  );

  static Future<bool?> initialize() async {
    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: DarwinInitializationSettings(),
    );
    final res = await _flutterLocalNotificationsPlugin
        .initialize(initializationSettings);
    _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestPermission();
    return res;
  }

  static void displayNotification(RemoteMessage message) async {
    try {
      await _flutterLocalNotificationsPlugin.show(
          message.hashCode,
          message.notification!.title,
          message.notification!.body,
          _notificationDetails);
    } catch (e) {
      log(e.toString());
    }
  }
}
