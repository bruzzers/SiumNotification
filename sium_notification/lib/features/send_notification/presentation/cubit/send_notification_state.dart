part of 'send_notification_cubit.dart';

class SendNotificationState extends BaseState{
  final bool? isLoading;

  @override
  List<Object?> get props => [isLoading];

  SendNotificationState({
    this.isLoading,
  });

  SendNotificationState copyWith({
    bool? isLoading,
  }) {
    return SendNotificationState(
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
