// coverage:ignore-file
import 'package:flutter/material.dart';
import 'package:sium_notification/core/model/notification_model.dart';

class NotificationItem extends StatelessWidget{
  final NotificationModel? model;

  NotificationItem({required this.model});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(model?.title ?? ""),
          Text(model?.date ?? ""),
          Text(model?.sentBy ?? "")
        ],
      ),
    );
  }

}