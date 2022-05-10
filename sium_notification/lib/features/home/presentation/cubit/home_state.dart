part of 'home_cubit.dart';

class HomeState extends BaseState {
  final List<NotificationModel>? notifications;
  final bool? isLoading;

  @override
  List<Object?> get props => [notifications, isLoading];

  HomeState({
    this.isLoading, this.notifications
  });

  HomeState copyWith({
    List<NotificationModel>? notifications,
    bool? isLoading,
  }) {
    return HomeState(
      notifications: notifications ?? this.notifications,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
