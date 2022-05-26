part of 'own_notification_cubit.dart';

class OwnNotificationState extends BaseState{
  final List<NotificationModel>? notifications;
  final bool? isLoading;

  @override
  List<Object?> get props => [notifications, isLoading];

  OwnNotificationState({
    this.notifications,
    this.isLoading,
  });

  OwnNotificationState copyWith({
    List<NotificationModel>? notifications,
    bool? isLoading,
  }) {
    return OwnNotificationState(
      notifications: notifications ?? this.notifications,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
