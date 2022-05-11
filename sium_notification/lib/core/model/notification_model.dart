import 'package:equatable/equatable.dart';

class NotificationModel extends Equatable{
  final String? title;
  final String? sentBy;
  final String? sentByUid;
  final DateTime? date;
  final String? position;
  final String? floor;
  final String? id;
  final String? room;
  final String? note;

  const NotificationModel({
    this.title,
    this.sentBy,
    this.sentByUid,
    this.date,
    this.position,
    this.floor,
    this.id,
    this.room,
    this.note
  });

  @override
  // TODO: implement props
  List<Object?> get props => [title, sentBy, sentByUid, date, position, floor, id, room, note];
}
