import 'package:equatable/equatable.dart';

class NotificationVoteModel extends Equatable{
  final int? vote;
  final String? sentByUid;
  @override
  // TODO: implement props
  List<Object?> get props => [vote, sentByUid];

  const NotificationVoteModel({
    this.vote,
    this.sentByUid,
  });
}