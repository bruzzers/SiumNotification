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

    final currentUser = repository.getCurrentUser();
    if(detail?.votes?.any((element) => element.sentByUid == currentUser?.uid) == true){
      emit(state.copyWith(selectedVote: detail?.votes?.firstWhere((element) => element.sentByUid == currentUser?.uid).vote));
    }
  }

  Future<void> sendNotificationCommentAndVote() async{
    emit(state.copyWith(isLoading: true));
    await repository.sendNotificationComment(commentController.text, state.detail, state.selectedVote);

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

  void selectVote(int element) {
    emit(state.copyWith(selectedVote: element));
  }

  double? getAverageVote(){
    if(state.detail?.votes?.isNotEmpty == true){
      int total = 0;
      int number = 0;
      state.detail?.votes?.forEach((element) {
        total = total + (element.vote ?? 0);
        number++;
      });
      return total/number;
    }else{
      return null;
    }
  }
}
