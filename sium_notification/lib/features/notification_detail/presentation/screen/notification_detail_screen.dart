// coverage:ignore-file
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sium_notification/core/component/sium_base_screen.dart';
import 'package:sium_notification/core/component/sium_text.dart';
import 'package:sium_notification/core/constants/text_styles.dart';
import 'package:sium_notification/features/home/presentation/component/notification_profile_image.dart';
import 'package:sium_notification/features/notification_detail/presentation/component/notification_comment_input_box.dart';
import 'package:sium_notification/features/notification_detail/presentation/cubit/notification_detail_cubit.dart';

import '../../../../core/component/sium_button.dart';

class NotificationDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationDetailCubit, NotificationDetailState>(
        builder: (context, state) {
      return SiumBaseScreen(
          body: SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.only(top: 12.0, left: 18.0, right: 18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SiumText(
                            "SIUUUUM, nuova notifica",
                            style: sium28Bold,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 12.0),
                            child: SiumText(
                              state.detail?.title ?? "",
                              style: sium18Bold,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 12.0),
                            child: Row(
                              children: [
                                SiumText(
                                  "Inviato da: ${state.detail?.sentBy}",
                                  style: sium16Regular,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: NotificationProfileImage(
                                    imageUrl: state.detail?.imageUrl,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 12.0),
                            child: SiumText(
                              "Posizione: ${state.detail?.position}",
                              style: sium16Regular,
                            ),
                          ),
                          if (state.detail?.floor?.isNotEmpty == true)
                            Padding(
                              padding: const EdgeInsets.only(top: 12.0),
                              child: SiumText("Piano: ${state.detail?.floor}",
                                  style: sium16Regular),
                            ),
                          if (state.detail?.room?.isNotEmpty == true)
                            Padding(
                              padding: const EdgeInsets.only(top: 12.0),
                              child: SiumText("Stanza: ${state.detail?.room}",
                                  style: sium16Regular),
                            ),
                          if (state.detail?.note?.isNotEmpty == true)
                            Padding(
                              padding: const EdgeInsets.only(top: 12.0),
                              child: SiumText(
                                  "Note aggiuntive: ${state.detail?.note}",
                                  style: sium16Regular),
                            ),
                        ],
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 24.0),
                    child: SiumText(
                      "Inserisci un commento",
                      style: sium16Bold,
                    ),
                  ),
                  NotificationCommentInputBox(
                      controller: context
                          .read<NotificationDetailCubit>()
                          .commentController,
                      onFieldSubmitted: (_) => context.read<NotificationDetailCubit>().sendNotificationComment()),
                  Padding(
                    padding: const EdgeInsets.only(top: 18.0),
                    child: SiumButton(
                      color: Colors.blue,
                      text: "Invia",
                      onTap: () => context.read<NotificationDetailCubit>().sendNotificationComment(),
                    ),
                  )
                ],
              ),
            ),
          ),
          title: "Dettaglio notifica",
          loading: state.isLoading);
    });
  }
}