part of 'login_cubit.dart';

class LoginState extends BaseState{
  final bool? passwordObscured;
  @override
  // TODO: implement props
  List<Object?> get props => [passwordObscured];

  LoginState({
    this.passwordObscured,
  });

  LoginState copyWith({
    bool? passwordObscured,
  }) {
    return LoginState(
      passwordObscured: passwordObscured ?? this.passwordObscured,
    );
  }
}
