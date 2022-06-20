import 'package:bloc/bloc.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sium_notification/core/model/notification_model.dart';
import 'package:sium_notification/core/session_manager/session_manager.dart';
import 'package:sium_notification/core/state_management/base_cubit.dart';
import 'package:sium_notification/features/home/repository/home_repository.dart';
import 'package:sium_notification/utils/di_service.dart';
import 'package:sium_notification/utils/routes.dart';

part 'home_state.dart';

class HomeCubit extends BaseCubit<HomeState> {
  final HomeRepository repository;
  final SessionManager sessionManager;
  final SharedPreferences prefs;
  HomeCubit(this.repository, this.sessionManager, this.prefs) : super(HomeState());

  Future<void> onInit() async{
    emit(state.copyWith(isLoading: true));
    emit(state.copyWith(visibleName: sessionManager.getUser()?.displayName ?? sessionManager.getUser()?.email));
    await repository.registerToTopic();
    final res = await repository.getNotifications();
    final messaging = await FirebaseMessaging.instance.getToken();
    print("TOKEN FIREBASE: $messaging");

    if(res.isNotEmpty){
      final sharedNotId = prefs.getString("notificationId");
      if(sharedNotId != null && sharedNotId.isNotEmpty){
        if(res.any((element) => element.id == sharedNotId)){
          prefs.remove("notificationId");
          Get.toNamed(Routes.notificationDetail, arguments: res.firstWhere((element) => element.id == sharedNotId));
        }else{
          Get.toNamed(Routes.ownNotifications);
        }
      }
      res.sort((a, b) {
        if(a.date?.isBefore(b.date ?? DateTime.now()) == true){
          return 1;
        }else {
          return -1;
        }
      });
      emit(state.copyWith(notifications: res));

      final notId = prefs.getString("notificationId");
      if(notId?.isNotEmpty == true && notId != null){
        final notificationDetail = state.notifications?.firstWhere((element) => element.id == notId, orElse: () => NotificationModel(id: null));
        if(notificationDetail?.id != null){
          prefs.remove("notificationId");
          goToDetail(notificationDetail);
        }
      }
    }else{
      emit(state.copyWith(notifications: []));
    }
    emit(state.copyWith(isLoading: false));
  }

  Future<void> goToDetail(NotificationModel? notificationModel) async{
    await Get.toNamed(Routes.notificationDetail, arguments: notificationModel);

    onInit();
  }

  double? getAverageVote(NotificationModel? notification) {
    if(notification?.votes?.isNotEmpty == true){
      int total = 0;
      int number = 0;
      notification?.votes?.forEach((element) {
        total = total + (element.vote ?? 0);
        number++;
      });
      return total/number;
    }else{
      return null;
    }
  }

  Future<void> goToOwnNotifications() async{
    await Get.toNamed(Routes.ownNotifications);

    onInit();
  }
}
