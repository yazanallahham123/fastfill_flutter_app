import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'local_data.dart';

class LocalNotificationService {
  static final LocalNotificationService _localNotificationService =
      LocalNotificationService._internal();

  factory LocalNotificationService() {
    return _localNotificationService;
  }

  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static void initialize({BuildContext? context}) {
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: AndroidInitializationSettings("@mipmap/ic_launcher"),
            iOS: IOSInitializationSettings());

    _notificationsPlugin.initialize(
      initializationSettings,
      onSelectNotification: (String? route) async {
        if (route != null && context != null)
          Navigator.pushNamed(context, route);
      },
    );
  }

  static void display(RemoteMessage message) async {
    try {
      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;

      final NotificationDetails notificationDetails = NotificationDetails(
          android: AndroidNotificationDetails(
              "akelbety", "akelbety channel", channelDescription:  "Channel app",
              importance: Importance.max,
              playSound: true,
              priority: Priority.high));

      await _notificationsPlugin.show(id, message.notification!.title,
          message.notification!.body, notificationDetails,
          payload: message.data['route']);
    } catch (e) {
      print(e);
    }
  }

  LocalNotificationService._internal();
}

void firebaseMessagingInit(BuildContext context) async {
  FirebaseMessaging messagingInstance = FirebaseMessaging.instance;

  messagingInstance.setForegroundNotificationPresentationOptions(
      sound: true, alert: true, badge: true);

  await messagingInstance.getToken().then((value) async {
    print("Your token is: " + value.toString());
    //TODO: upload the value to Mysql database
    await LocalData().setFTokenValue(value as String);
  });

  messagingInstance.getInitialMessage().then((message) {
    if (message != null) Navigator.of(context).pushNamed(message.data['route']);
  });
  FirebaseMessaging.onMessage.listen((message) {
    if (message.notification != null) {
      print("The Notification title is: " +
          message.notification!.title.toString());
      print("The Notification Message is: " +
          message.notification!.body.toString());
    }

    LocalNotificationService.display(message);
  });
  FirebaseMessaging.onMessageOpenedApp.listen((message) {
    print("This is route: " + message.data['route']);
    Navigator.of(context).pushNamed(message.data['route']);
  });
}
