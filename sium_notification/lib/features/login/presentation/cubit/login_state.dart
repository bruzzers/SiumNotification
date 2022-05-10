part of 'login_cubit.dart';

class LoginState extends BaseState{
  final bool? passwordObscured;
  final bool? isLoading;
  @override
  // TODO: implement props
  List<Object?> get props => [passwordObscured, isLoading];

  LoginState({
    this.passwordObscured,
    this.isLoading
  });

  LoginState copyWith({
    bool? passwordObscured,
    bool? isLoading
  }) {
    return LoginState(
      passwordObscured: passwordObscured ?? this.passwordObscured,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
