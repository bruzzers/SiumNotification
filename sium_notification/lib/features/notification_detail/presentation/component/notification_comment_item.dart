// coverage:ignore-file
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sium_notification/core/component/sium_text.dart';
import 'package:sium_notification/core/constants/text_styles.dart';
import 'package:sium_notification/core/model/comments_model.dart';
import 'package:sium_notification/features/home/presentation/component/notification_profile_image.dart';

class NotificationCommentItem extends StatelessWidget{
  const NotificationCommentItem({
    required this.comment,
  });

  final CommentsModel? comment;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              NotificationProfileImage(imageUrl: comment?.imageUrl,),
              Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: SiumText(comment?.sentBy ?? "", style: sium16Bold,),
              ),
            ],
          ),
          SiumText(comment?.comment ?? "", style: sium16Regular,),
          const Padding(
            padding: EdgeInsets.only(top: 12.0),
            child: Divider(height: 1, color: Colors.grey, thickness: 1,),
          )
        ],
      ),
    );
  }}