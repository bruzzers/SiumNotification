import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sium_notification/utils/di_service.dart';
import 'package:sium_notification/utils/routes.dart';
import 'utils/di_service.dart' as di;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await di.init();
  await Firebase.initializeApp();

  //When app is terminated
  FirebaseMessaging.instance.getInitialMessage().then((message) async{
    if (message != null) {
      print(
          "Application opened when closed with notification: ${message.notification?.title}");
    }
  });

  //Firebase when App in background state gets Opened
  FirebaseMessaging.onMessageOpenedApp.listen((message) {
    print(
        "Application opened when in background state with notification: ${message.notification?.title}");
  });

  //Firebase Foreground Messaging Handler
  FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    await localNotificationService.initialize(message);

    if (message.notification != null) {
      localNotificationService.display(message);
    }
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
