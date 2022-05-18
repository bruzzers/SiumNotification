import 'package:sium_notification/core/model/notification_model.dart';
import 'package:sium_notification/core/state_management/base_cubit.dart';

part 'notification_detail_state.dart';

class NotificationDetailCubit extends BaseCubit<NotificationDetailState> {
  NotificationDetailCubit() : super(NotificationDetailState());

  void onInit(NotificationModel? detail){
    emit(state.copyWith(detail: detail));
  }
}
