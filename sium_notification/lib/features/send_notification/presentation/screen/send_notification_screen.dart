// coverage:ignore-file
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sium_notification/core/component/sium_base_screen.dart';
import 'package:sium_notification/core/component/sium_text.dart';
import 'package:sium_notification/core/constants/text_styles.dart';
import 'package:sium_notification/features/send_notification/presentation/cubit/send_notification_cubit.dart';

class SendNotificationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SendNotificationCubit, SendNotificationState>(
        builder: (context, state) {
      return SiumBaseScreen(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 18.0, right: 18.0, top: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SiumText("Invia subito la push ai tuoi colleghi, non vedono l'ora!", style: sium18Bold,),
                  ],
                ),
              ),
            ),
          ),
          title: "Invia Notifica",
          loading: state.isLoading);
    });
  }
}
