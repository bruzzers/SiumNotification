import 'package:flutter/material.dart';
import 'package:sium_notification/core/model/comments_model.dart';
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
    emit(state.copyWith(isLoading: true));
    await repository.sendNotificationComment(commentController.text, state.detail?.id);

    await _updateDetail();
    emit(state.copyWith(isLoading: false));
  }

  Future<void> _updateDetail() async {
    final newDetail = NotificationModel.clone(state.detail);

    final commentList = newDetail.comments?.map((e) => CommentsModel.clone(e)).toList();
    final currentUser = repository.getCurrentUser();
    final newCommentModel = CommentsModel(
      sentBy: currentUser?.displayName ?? currentUser?.email ?? "",
      sentByUid: currentUser?.uid,
      comment: commentController.text,
      imageUrl: currentUser?.photoURL
    );

    commentList?.add(newCommentModel);
    newDetail.comments = commentList;

    emit(state.copyWith(detail: newDetail));
  }
}
