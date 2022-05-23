// coverage:ignore-file
import 'package:flutter/material.dart';
import 'package:sium_notification/core/component/sium_text.dart';
import 'package:sium_notification/core/constants/text_styles.dart';
import 'package:sium_notification/core/model/notification_model.dart';
import 'package:sium_notification/features/home/presentation/component/notification_sium_image.dart';
import 'package:sium_notification/utils/di_service.dart';

import 'notification_profile_image.dart';

class NotificationItem extends StatelessWidget{
  final NotificationModel? model;
  final VoidCallback onItemTap;
  final double? avgVote;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onItemTap,
      child: Column(
        children: [
          Container(
            color: Colors.blue.shade50,
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 18.0, right: 18.0, bottom: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SiumText(model?.title ?? "", style: sium18Bold,),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Row(
                      children: [
                        Expanded(child: SiumText(model?.position ?? "", style: sium14Regular,)),
                        if(model?.floor?.isNotEmpty == true)
                        Expanded(child: SiumText(
                          "Piano: ${model?.floor ?? ""}", style: sium14Regular,)),
                      ],
                    ),
                  ),
                  if(model?.room?.isNotEmpty == true)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: SiumText("Stanza: ${model?.room}", style: sium14Regular,),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Row(
                      children: [
                        Expanded(child: SiumText("Inviato da: ${model?.sentBy ?? ""}", style: sium14Regular,)),
                        NotificationProfileImage(imageUrl: model?.imageUrl,)
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 12.0),
                    child: Row(
                      children: [
                        Expanded(child: SiumText(dateUtils.parseStringDate(model?.date) ?? "", style: sium12Regular,)),
                        if(avgVote != null)
                          SiumText("Valutazione: $avgVote", style: sium12Regular,),
                        if(avgVote != null && (avgVote ?? 0) >= 9.0)
                           Padding(
                             padding: const EdgeInsets.only(left: 8.0),
                             child: NotificationSiumImage(),
                           )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Divider(color: Colors.grey, height: 1, thickness: 1,)
        ],
      ),
    );
  }

  const NotificationItem({
    required this.model,
    required this.onItemTap,
    this.avgVote,
  });
}