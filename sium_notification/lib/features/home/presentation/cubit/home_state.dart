part of 'home_cubit.dart';

class HomeState extends BaseState {
  final List<NotificationModel>? notifications;
  final String? visibleName;
  final bool? isLoading;

  @override
  List<Object?> get props => [notifications, visibleName, isLoading];

  HomeState({
    this.isLoading, this.notifications, this.visibleName
  });

  HomeState copyWith({
    List<NotificationModel>? notifications,
    String? visibleName,
    bool? isLoading,
  }) {
    return HomeState(
      notifications: notifications ?? this.notifications,
      visibleName: visibleName ?? this.visibleName,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
