import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:sium_notification/utils/di_service.dart';
import 'package:sium_notification/utils/routes.dart';
import 'utils/di_service.dart' as di;

Future<void> showRemoteMessage(RemoteMessage message) async {
  final newMessage = RemoteMessage(
      data: message.data,
      senderId: message.senderId,
      category: message.category,
      collapseKey: message.collapseKey,
      contentAvailable: message.contentAvailable,
      from: message.from,
      messageId: message.messageId,
      messageType: message.messageType,
      mutableContent: message.mutableContent,
      sentTime: message.sentTime,
      threadId: message.threadId,
      ttl: message.ttl,
      notification: const RemoteNotification(
          title: "C'è un nuovo commento",
          body: "Una SIUM con cui hai interagito ha un nuovo commento"));
  try {
    await Firebase.initializeApp();
    final currentUser = FirebaseAuth.instance.currentUser;
    final uidList = newMessage.data["uid"] != null
        ? jsonDecode(newMessage.data["uid"]) as Iterable
        : [];
    if (uidList.contains(currentUser?.uid) || uidList.isEmpty) {
      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;

      const NotificationDetails notificationDetails = NotificationDetails(
          android: AndroidNotificationDetails(
            "SiumNotification",
            "SiumNotification Channel",
            importance: Importance.max,
            priority: Priority.high,
          ),
          iOS: IOSNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
          ));

      await FlutterLocalNotificationsPlugin().show(
        id,
        newMessage.notification?.title,
        newMessage.notification?.body,
        notificationDetails,
        payload: newMessage.data["route"],
      );
    }
  } on Exception catch (e) {
    print(e);
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await di.init();
  await Firebase.initializeApp();

  //When app is terminated
  FirebaseMessaging.instance.getInitialMessage().then((message) async {
    if (message != null) {
      prefs.setString("notificationId", message.data["notificationId"]);
      print(
          "Application opened when closed with notification: ${message.notification?.title}");
    }
  });

  //Firebase when App in background state gets Opened
  FirebaseMessaging.onMessageOpenedApp.listen((message) {
    prefs.setString("notificationId", message.data["notificationId"]);
    if (Get.currentRoute != Routes.splash && Get.currentRoute != Routes.login) {
      Get.offAndToNamed(Routes.main);
    }
    print(
        "Application opened when in background state with notification: ${message.notification?.title}");
  });

  FirebaseMessaging.onBackgroundMessage(showRemoteMessage);

  //Firebase Foreground Messaging Handler
  FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    await localNotificationService.initialize(message);

    localNotificationService.display(message);
  });

  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('it'),
      ],
      path: 'assets/translations',
      fallbackLocale: const Locale('it'),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      smartManagement: SmartManagement.full,
      initialRoute: Routes.splash,
      defaultTransition: Transition.rightToLeft,
      getPages: Routes.pages,
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
      locale: context.locale,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.light,
    );
  }
}
