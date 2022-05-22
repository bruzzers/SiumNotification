part of 'notification_detail_cubit.dart';

class NotificationDetailState extends BaseState{
  final bool? isLoading;
  final NotificationModel? detail;
  final int? selectedVote;

  @override
  List<Object?> get props => [detail, isLoading, selectedVote];

  NotificationDetailState({
    this.isLoading,
    this.detail,
    this.selectedVote
  });

  NotificationDetailState copyWith({
    bool? isLoading,
    NotificationModel? detail,
    int? selectedVote,
  }) {
    return NotificationDetailState(
      isLoading: isLoading ?? this.isLoading,
      detail: detail ?? this.detail,
      selectedVote: selectedVote ?? this.selectedVote,
    );
  }
}
