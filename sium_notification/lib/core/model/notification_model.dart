import 'package:equatable/equatable.dart';

class NotificationModel extends Equatable{
  final String? title;
  final String? sentBy;
  final String? sentByUid;
  final String? date;
  final String? position;
  final String? floor;
  final String? id;

  const NotificationModel({
    this.title,
    this.sentBy,
    this.sentByUid,
    this.date,
    this.position,
    this.floor,
    this.id,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [title, sentBy, sentByUid, date, position, floor, id];
}
