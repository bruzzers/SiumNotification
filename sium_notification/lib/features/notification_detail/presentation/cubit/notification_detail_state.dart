part of 'notification_detail_cubit.dart';

class NotificationDetailState extends BaseState{
  final bool? isLoading;
  final NotificationModel? detail;

  @override
  List<Object?> get props => [detail, isLoading];

  NotificationDetailState({
    this.isLoading,
    this.detail,
  });

  NotificationDetailState copyWith({
    bool? isLoading,
    NotificationModel? detail,
  }) {
    return NotificationDetailState(
      isLoading: isLoading ?? this.isLoading,
      detail: detail ?? this.detail,
    );
  }
}
