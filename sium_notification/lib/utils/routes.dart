// coverage:ignore-file
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:sium_notification/features/login/presentation/cubit/login_cubit.dart';
import 'package:sium_notification/features/login/presentation/screen/login_screen.dart';
import 'package:sium_notification/features/splash/presentation/cubit/splash_cubit.dart';
import 'package:sium_notification/features/splash/presentation/screen/splash_screen.dart';
import 'package:sium_notification/utils/di_service.dart';

class Routes{
  Routes._();

  static const String splash = '/';
  static const String login = '/login';

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
        create: (_) => LoginCubit(loginRepo),
        child: LoginScreen(),
      ),
    ),
  ];
}