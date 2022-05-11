// coverage:ignore-file
import 'package:flutter/material.dart';
import 'package:sium_notification/core/constants/text_styles.dart';
import 'package:sium_notification/core/model/notification_model.dart';
import 'package:sium_notification/utils/di_service.dart';

class NotificationItem extends StatelessWidget{
  final NotificationModel? model;

  const NotificationItem({required this.model});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(width: 1),
          borderRadius: BorderRadius.circular(16.0),
          color: const Color(0xFFE4F3F8)
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0, bottom: 18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(model?.title ?? "", style: sium18Bold,),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(
                  children: [
                    Text(model?.position ?? "", style: sium14Regular,),
                    if(model?.floor?.isNotEmpty == true)
                    Text(model?.floor ?? "", style: sium14Regular,),
                  ],
                ),
              ),
              if(model?.room?.isNotEmpty == true)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text("Stanza: ${model?.room}", style: sium14Regular,),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text("Inviato da: ${model?.sentBy ?? ""}", style: sium14Regular,),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(dateUtils.parseStringDate(model?.date) ?? "", style: sium12Regular,),
              ),
            ],
          ),
        ),
      ),
    );
  }

}