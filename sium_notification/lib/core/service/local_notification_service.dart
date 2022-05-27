// coverage:ignore-file
import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:sium_notification/utils/di_service.dart';

import '../../utils/routes.dart';

abstract class LocalNotificationService {
  Future<void> initialize(RemoteMessage? message);

  Future<void> display(RemoteMessage message);
}

class LocalNotificationServiceImpl extends LocalNotificationService {

  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  Future<void> initialize(RemoteMessage? message) async {
    const InitializationSettings initializationSettings =
        InitializationSettings(
            android: AndroidInitializationSettings("@mipmap/ic_launcher"),
            iOS: IOSInitializationSettings(
              requestSoundPermission: true,
              requestBadgePermission: true,
              requestAlertPermission: true,
            ));

    await _notificationsPlugin.initialize(initializationSettings, onSelectNotification: (payload){
      if(Get.currentRoute != Routes.splash && Get.currentRoute != Routes.login){
        prefs.setString("notificationId", message?.data["notificationId"]);
        Get.offAndToNamed(Routes.main);
      }
    });
  }

  @override
  Future<void> display(RemoteMessage message) async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      final uidList = message.data["uid"] != null ? jsonDecode(message.data["uid"]) as Iterable : [];
      if(uidList.contains(currentUser?.uid) || uidList.isEmpty) {
        final id = DateTime
            .now()
            .millisecondsSinceEpoch ~/ 1000;

        const NotificationDetails notificationDetails = NotificationDetails(
            android: AndroidNotificationDetails(
              "SiumNotification",
              "SiumNotification Channel",
              sound: RawResourceAndroidNotificationSound("sium_not"),
              playSound: true,
              importance: Importance.max,
              priority: Priority.high,
            ),
            iOS: IOSNotificationDetails(
              presentAlert: true,
              presentBadge: true,
              presentSound: true,
            ));

        await _notificationsPlugin.show(
          id,
          message.notification?.title ?? "Hai una nuova notifica",
          message.notification?.body ?? "",
          notificationDetails,
          payload: message.data["route"],
        );
      }
    } on Exception catch (e) {
      print(e);
    }
  }
}
