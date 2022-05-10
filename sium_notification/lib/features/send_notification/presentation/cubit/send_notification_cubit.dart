import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sium_notification/core/state_management/base_cubit.dart';

part 'send_notification_state.dart';

class SendNotificationCubit extends BaseCubit<SendNotificationState> {
  SendNotificationCubit() : super(SendNotificationState());
}
