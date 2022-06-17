part of 'send_notification_cubit.dart';

class SendNotificationState extends BaseState{
  final bool? ctaActive;
  final bool? isLoading;
  final String? notificationImageUrl;
  final List<DropdownMenuItem<String>>? offices;
  final String? selectedOffice;

  @override
  List<Object?> get props => [isLoading, offices, selectedOffice, ctaActive, notificationImageUrl];

  SendNotificationState({
    this.ctaActive,
    this.isLoading,
    this.offices,
    this.selectedOffice,
    this.notificationImageUrl
  });

  SendNotificationState copyWith({
    bool? ctaActive,
    bool? isLoading,
    String? notificationImageUrl,
    List<DropdownMenuItem<String>>? offices,
    String? selectedOffice,
  }) {
    return SendNotificationState(
      ctaActive: ctaActive ?? this.ctaActive,
      isLoading: isLoading ?? this.isLoading,
      notificationImageUrl: notificationImageUrl ?? this.notificationImageUrl,
      offices: offices ?? this.offices,
      selectedOffice: selectedOffice ?? this.selectedOffice,
    );
  }
}
