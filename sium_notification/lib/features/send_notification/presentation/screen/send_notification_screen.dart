// coverage:ignore-file
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sium_notification/core/component/sium_base_screen.dart';
import 'package:sium_notification/core/component/sium_button.dart';
import 'package:sium_notification/core/component/sium_text.dart';
import 'package:sium_notification/core/constants/text_styles.dart';
import 'package:sium_notification/features/send_notification/presentation/component/send_notification_dropdown.dart';
import 'package:sium_notification/features/send_notification/presentation/component/send_notification_input_box.dart';
import 'package:sium_notification/features/send_notification/presentation/component/send_notification_text_field.dart';
import 'package:sium_notification/features/send_notification/presentation/cubit/send_notification_cubit.dart';

class SendNotificationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SendNotificationCubit, SendNotificationState>(
        builder: (context, state) {
      return InkWell(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: SiumBaseScreen(
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 18.0, right: 18.0, top: 12.0, bottom: 18.0),
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SiumText(
                              "Invia subito la push ai tuoi colleghi, non vedono l'ora!",
                              style: sium18Bold,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 6.0),
                              child: SendNotificationTextField(
                                  title: "Titolo*",
                                  hint: "Inserisci un titolo",
                                  controller: context
                                      .read<SendNotificationCubit>()
                                      .titleController,
                                  isLast: false),
                            ),
                            SendNotificationDropdown(
                              items: state.offices ?? [],
                              onChanged: (value) => context
                                  .read<SendNotificationCubit>()
                                  .updateSelectedOffice(value),
                              selectedItem: state.selectedOffice,
                            ),
                            SendNotificationTextField(
                                title: "Piano",
                                hint: "Inserisci il piano",
                                controller: context
                                    .read<SendNotificationCubit>()
                                    .floorController,
                                isLast: false),
                            SendNotificationTextField(
                                title: "Stanza",
                                hint: "Inserisci la stanza",
                                controller: context
                                    .read<SendNotificationCubit>()
                                    .roomController,
                                isLast: false),
                            SendNotificationInputBox(
                              controller: context
                                  .read<SendNotificationCubit>()
                                  .noteController,
                              onFieldSubmitted: (_) {},
                            )
                          ],
                        ),
                      ),
                    ),
                    SiumButton(
                      color: Colors.blue,
                      text: "Invia notifica",
                      onTap: state.ctaActive == true ? () {} : null,
                    )
                  ],
                ),
              ),
            ),
            title: "Invia Notifica",
            loading: state.isLoading),
      );
    });
  }
}
