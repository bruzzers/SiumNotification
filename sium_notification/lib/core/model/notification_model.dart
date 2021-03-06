import 'package:equatable/equatable.dart';
import 'package:sium_notification/core/model/comments_model.dart';

import 'notification_vote_model.dart';

class NotificationModel extends Equatable {
  final String? title;
  final String? imageUrl;
  final String? sentBy;
  final String? sentByUid;
  final DateTime? date;
  final String? position;
  final String? floor;
  final String? id;
  final String? room;
  final String? note;
  List<CommentsModel>? comments;
  List<NotificationVoteModel>? votes;
  final String? notificationImageUrl;

  NotificationModel.clone(NotificationModel? source)
      : title = source?.title,
        imageUrl = source?.imageUrl,
        sentBy = source?.sentBy,
        sentByUid = source?.sentByUid,
        date = source?.date,
        position = source?.position,
        floor = source?.floor,
        id = source?.id,
        room = source?.room,
        note = source?.note,
        comments = source?.comments,
        votes = source?.votes,
        notificationImageUrl = source?.notificationImageUrl;

  @override
  // TODO: implement props
  List<Object?> get props => [
        title,
        sentBy,
        sentByUid,
        date,
        position,
        floor,
        id,
        room,
        note,
        imageUrl,
        comments,
        votes,
        notificationImageUrl
      ];

  NotificationModel({
    this.title,
    this.imageUrl,
    this.sentBy,
    this.sentByUid,
    this.date,
    this.position,
    this.floor,
    this.id,
    this.room,
    this.note,
    this.comments,
    this.votes,
    this.notificationImageUrl,
  });
}
