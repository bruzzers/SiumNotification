// coverage:ignore-file
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sium_notification/core/component/sium_base_screen.dart';
import 'package:sium_notification/core/component/sium_text.dart';
import 'package:sium_notification/core/constants/text_styles.dart';
import 'package:sium_notification/features/notification_detail/presentation/cubit/notification_detail_cubit.dart';

class NotificationDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationDetailCubit, NotificationDetailState>(
        builder: (context, state) {
      return SiumBaseScreen(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SiumText("SIUUUUM, nuova notifica", style: sium28Bold,),
                  SiumText(state.detail?.title ?? "", style: sium18Bold,)
                ],
              ),
            ),
          ),
          title: "Dettaglio notifica",
          loading: state.isLoading);
    });
  }
}
