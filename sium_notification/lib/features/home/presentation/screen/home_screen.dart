// coverage:ignore-file
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sium_notification/core/component/sium_base_screen.dart';
import 'package:sium_notification/core/component/sium_text.dart';
import 'package:sium_notification/core/constants/text_styles.dart';
import 'package:sium_notification/features/home/presentation/component/notification_item.dart';
import 'package:sium_notification/features/home/presentation/cubit/home_cubit.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
      return SiumBaseScreen(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 18.0, right: 18.0),
                    child: Text(
                      "Bentornato ${state.visibleName}",
                      style: sium28Bold,
                    ),
                  ),
                  const Padding(
                    padding:
                        EdgeInsets.only(top: 18.0, left: 18.0, right: 18.0),
                    child: Text(
                      "Qua puoi trovare le notifiche inviate dai tuoi colleghi",
                      style: sium18Bold,
                    ),
                  ),
                  if(state.notifications?.isNotEmpty == true)
                  ListView.builder(
                    itemBuilder: (context, index) {
                      return NotificationItem(
                          model: state.notifications?[index]);
                    },
                    itemCount: state.notifications?.length ?? 0,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.only(top: 18.0, bottom: 6.0),
                    shrinkWrap: true,
                  )
                  else
                    const Padding(
                      padding: EdgeInsets.only(left: 18.0, right: 18.0, top: 12.0),
                      child: SiumText("Nessuno ha ancora inviato delle notifiche", style: sium28Bold,),
                    )
                ],
              ),
            ),
          ),
          title: "Home",
          loading: state.isLoading);
    });
  }
}
