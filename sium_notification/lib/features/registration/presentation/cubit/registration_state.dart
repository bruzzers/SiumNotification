part of 'registration_cubit.dart';

class RegistrationState extends BaseState{
  final bool? isLoading;

  @override
  // TODO: implement props
  List<Object?> get props => [isLoading];

  RegistrationState({
    this.isLoading,
  });

  RegistrationState copyWith({
    bool? isLoading,
  }) {
    return RegistrationState(
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
