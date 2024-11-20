
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final localNotificationsPlugin = FlutterLocalNotificationsPlugin();

class NotificationService {

  static final NotificationService _notificationService = NotificationService._internal();

  factory NotificationService() {
    return _notificationService;
  }

  NotificationService._internal();

  Future<void> init() async {
    FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(alert: true, badge: true, sound: true);

    if (kIsWeb) return;

    if (!Platform.isAndroid) {
      FirebaseMessaging messaging = FirebaseMessaging.instance;
      NotificationSettings settings = await messaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );

      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        debugPrint('User granted permission');
      } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
        debugPrint('User granted provisional permission');
      } else {
        debugPrint('User declined or has not accepted permission');
      }
    }

    const initializationSettingsAndroid =  AndroidInitializationSettings('app_icon');
    const initializationSettingsIOS = DarwinInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
      // onDidReceiveLocalNotification: onDidReceiveLocalNotification,
    );
    const initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
      macOS: null,
    );
    await localNotificationsPlugin.initialize(
      initializationSettings,
      // onSelectNotification: selectNotification
    );

  }

  static Future<void> showNotification(RemoteNotification? notification) async {
    debugPrint("SHOW NOTIFICATIONS : ${notification?.toMap()}");

    const androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'com.perigigi.godentist', //Required for Android 8.0 or after
      'com.perigigi.godentist',
      importance: Importance.max,
      priority: Priority.max,
      ticker: 'ticker',
    );

    const iOSPlatformChannelSpecifics = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    const notificationDetails = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    const idNotification = 0;

    await localNotificationsPlugin.show(
      idNotification,
      notification?.title,
      notification?.body,
      notificationDetails,
    );

  }

}
