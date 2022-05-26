// coverage:ignore-file
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sium_notification/core/component/sium_base_screen.dart';
import 'package:sium_notification/core/component/sium_text.dart';
import 'package:sium_notification/core/constants/text_styles.dart';
import 'package:sium_notification/features/home/presentation/component/notification_item.dart';
import 'package:sium_notification/features/own_notification/presentation/cubit/own_notification_cubit.dart';

class OwnNotificationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OwnNotificationCubit, OwnNotificationState>(
        builder: (context, state) {
      return SiumBaseScreen(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding:
                        EdgeInsets.only(top: 12.0, left: 18.0, right: 18.0),
                    child: SiumText(
                      "Qua puoi vedere le notifiche che hai inviato tu",
                      style: sium18Bold,
                    ),
                  ),
                  ListView.builder(
                    itemBuilder: (context, index) {
                      return Dismissible(
                          key: UniqueKey(),
                          direction: DismissDirection.endToStart,
                          background: Container(
                            color: Colors.red,
                            alignment: Alignment.centerRight,
                            child: const Padding(
                              padding: EdgeInsets.only(right: 20.0),
                              child: Icon(Icons.delete, color: Colors.white, size: 40.0,),
                            ),
                          ),
                          onDismissed: (_) => context.read<OwnNotificationCubit>().deleteNotification(state.notifications?[index], index),
                          child: NotificationItem(
                              model: state.notifications?[index],
                              onItemTap: () => context
                                  .read<OwnNotificationCubit>()
                                  .goToDetail(state.notifications?[index])));
                    },
                    itemCount: state.notifications?.length ?? 0,
                    shrinkWrap: true,
                    padding: const EdgeInsets.only(top: 12.0),
                    physics: const NeverScrollableScrollPhysics(),
                  )
                ],
              ),
            ),
          ),
          title: "Le tue notifiche",
          loading: state.isLoading);
    });
  }
}
