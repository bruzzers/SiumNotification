// coverage:ignore-file
import 'package:equatable/equatable.dart';

class CommentsModel extends Equatable{
  final String? sentBy;
  final String? sentByUid;
  final String? comment;
  final String? imageUrl;

  const CommentsModel({
    this.sentBy,
    this.sentByUid,
    this.comment,
    this.imageUrl
  });

  CommentsModel.clone(CommentsModel? source):
      sentBy = source?.sentBy,
  sentByUid = source?.sentByUid,
  comment = source?.comment,
  imageUrl = source?.imageUrl;

  @override
  // TODO: implement props
  List<Object?> get props => [sentBy, sentByUid, comment, imageUrl];
}