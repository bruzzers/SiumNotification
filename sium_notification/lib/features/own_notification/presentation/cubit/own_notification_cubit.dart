import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sium_notification/core/state_management/base_cubit.dart';
import 'package:sium_notification/utils/routes.dart';

import '../../../../core/model/notification_model.dart';
import '../../../../utils/date/date_utils.dart';
import '../../repository/own_notification_repository.dart';

part 'own_notification_state.dart';

class OwnNotificationCubit extends BaseCubit<OwnNotificationState> {
  final OwnNotificationRepository repository;
  final SiumDateUtils dateUtils;
  final SharedPreferences prefs;

  OwnNotificationCubit(this.repository, this.dateUtils, this.prefs)
      : super(OwnNotificationState());

  Future<void> onInit() async {
    emit(state.copyWith(isLoading: true));

    final res = await repository.getOwnNotification();

    final shareNotId = prefs.getString("notificationId");

    if(shareNotId != null && shareNotId.isNotEmpty){
      if(res.any((element) => element.id == shareNotId)){
        prefs.remove("notificationId");
        Get.toNamed(Routes.notificationDetail, arguments: res.firstWhere((element) => element.id == shareNotId));
      }
    }

    res.sort((a, b) {
      return dateUtils
              .parseStringDate(b.date)
              ?.compareTo(dateUtils.parseStringDate(a.date) ?? "") ??
          0;
    });

    emit(state.copyWith(notifications: res, isLoading: false));
  }

  Future<void> goToDetail(NotificationModel? model) async{
    await Get.toNamed(Routes.notificationDetail, arguments: model);

    onInit();
  }

  Future<void> deleteNotification(NotificationModel? notification, int index) async{
    emit(state.copyWith(isLoading: true));

    await repository.deleteNotification(notification);

    final newList = state.notifications?.map((e) => NotificationModel.clone(e)).toList();

    newList?.removeAt(index);

    emit(state.copyWith(isLoading: false, notifications: newList));
  }
}
