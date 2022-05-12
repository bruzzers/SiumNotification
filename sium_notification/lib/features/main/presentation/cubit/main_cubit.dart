import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sium_notification/core/state_management/base_cubit.dart';
import 'package:sium_notification/features/home/presentation/cubit/home_cubit.dart';
import 'package:sium_notification/features/home/presentation/screen/home_screen.dart';
import 'package:sium_notification/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:sium_notification/features/profile/presentation/screen/profile_screen.dart';
import 'package:sium_notification/features/send_notification/presentation/cubit/send_notification_cubit.dart';
import 'package:sium_notification/features/send_notification/presentation/screen/send_notification_screen.dart';
import 'package:sium_notification/utils/di_service.dart';

part 'main_state.dart';

class MainCubit extends BaseCubit<MainState> {
  late PageController controller;
  MainCubit() : super(MainState());

  void onInit() {
    emit(state.copyWith(index: 0));
    List<Widget> widgets = [BlocProvider(
      create: (_) => HomeCubit(homeRepo, sessionManager)..onInit(),
      child: HomeScreen(),
    ), BlocProvider(
      create: (_) => SendNotificationCubit(),
      child: SendNotificationScreen(),
    ), BlocProvider(
      create: (_) => ProfileCubit(profileRepo)..onInit(),
      child: ProfileScreen(),
    ),];
    List<BottomNavigationBarItem> items = const [
      BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home", tooltip: ''),
      BottomNavigationBarItem(icon: Icon(Icons.add), label: "Aggiungi", tooltip: ''),
      BottomNavigationBarItem(icon: Icon(Icons.account_circle_outlined), label: "Profilo", tooltip: ''),
    ];
    controller = PageController();

    emit(state.copyWith(childrenList: widgets, bottomItems: items));
  }

  void changeIndex(int index) {
    emit(state.copyWith(
        index: index,
        childrenList: state.childrenList,
        bottomItems: state.bottomItems));
    controller.animateToPage(index,
        duration: const Duration(milliseconds: 1), curve: Curves.linear);
  }
}
