// coverage:ignore-file
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:sium_notification/features/login/presentation/cubit/login_cubit.dart';
import 'package:sium_notification/features/login/presentation/screen/login_screen.dart';
import 'package:sium_notification/features/main/presentation/cubit/main_cubit.dart';
import 'package:sium_notification/features/main/presentation/screen/main_screen.dart';
import 'package:sium_notification/features/notification_detail/presentation/cubit/notification_detail_cubit.dart';
import 'package:sium_notification/features/registration/presentation/cubit/registration_cubit.dart';
import 'package:sium_notification/features/registration/presentation/screen/registration_screen.dart';
import 'package:sium_notification/features/splash/presentation/cubit/splash_cubit.dart';
import 'package:sium_notification/features/splash/presentation/screen/splash_screen.dart';
import 'package:sium_notification/utils/di_service.dart';

import '../features/notification_detail/presentation/screen/notification_detail_screen.dart';

class Routes{
  Routes._();

  static const String splash = '/';
  static const String login = '/login';
  static const String registration = '/registration';
  static const String main = '/main';
  static const String notificationDetail = '/main/notificationDetail';

  static final List<GetPage> pages = [
    GetPage(
      name: splash,
      page: () => BlocProvider(
        create: (_) => SplashCubit()..onInit(),
        child: SplashScreen(),
      ),
    ),
    GetPage(
      name: login,
      page: () => BlocProvider(
        create: (_) => LoginCubit(loginRepo, validator, sessionManager)..onInit(),
        child: LoginScreen(),
      ),
    ),
    GetPage(
      name: registration,
      page: () => BlocProvider(
        create: (_) => RegistrationCubit(registrationRepo, validator),
        child: RegistrationScreen(),
      ),
    ),
    GetPage(
      name: main,
      page: () => BlocProvider(
        create: (_) => MainCubit()..onInit(),
        child: MainScreen(),
      ),
    ),
    GetPage(
      name: notificationDetail,
      page: () => BlocProvider(
        create: (_) => NotificationDetailCubit()..onInit(Get.arguments),
        child: NotificationDetailScreen(),
      ),
    ),
  ];
}