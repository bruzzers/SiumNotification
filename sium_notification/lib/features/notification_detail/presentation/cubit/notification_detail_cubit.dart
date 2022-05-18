import 'package:flutter/material.dart';
import 'package:sium_notification/core/model/notification_model.dart';
import 'package:sium_notification/core/state_management/base_cubit.dart';

import '../../repository/notification_detail_repository.dart';

part 'notification_detail_state.dart';

class NotificationDetailCubit extends BaseCubit<NotificationDetailState> {
  final NotificationDetailRepository repository;

  late TextEditingController commentController;

  NotificationDetailCubit(this.repository) : super(NotificationDetailState()){
    commentController = TextEditingController();
  }

  void onInit(NotificationModel? detail){
    emit(state.copyWith(detail: detail));
  }

  Future<void> sendNotificationComment() async{
    await repository.sendNotificationComment(commentController.text, state.detail?.id);
  }
}
