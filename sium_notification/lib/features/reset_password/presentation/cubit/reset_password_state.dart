part of 'reset_password_cubit.dart';

class ResetPasswordState extends BaseState {
  final bool? isLoading;
  final String? emailError;

  @override
  List<Object?> get props =>
      [isLoading, emailError];

  bool get ctaEnabled => emailError == null;

  ResetPasswordState(
      {this.isLoading,
      this.emailError,});

  ResetPasswordState removeEmailError() {
    return ResetPasswordState(
        isLoading: isLoading,
        emailError: null,
    );
  }

  ResetPasswordState copyWith({
    bool? isLoading,
    bool? resetRequested,
    String? emailError,
    String? pswError,
    bool? passwordObscured,
  }) {
    return ResetPasswordState(
      isLoading: isLoading ?? this.isLoading,
      emailError: emailError ?? this.emailError,
    );
  }
}
