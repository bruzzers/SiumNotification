part of 'login_cubit.dart';

class LoginState extends BaseState{
  final bool? passwordObscured;
  final Map<String, String?>? errors;
  final bool? isLoading;

  bool get ctaIsEnabled {
    if(errors?.containsKey("email") == true && errors?.containsKey("psw") == true){
      if(errors?["email"] == null && errors?["psw"] == null){
        return true;
      }else{
        return false;
      }
    }else{
      return false;
    }
  }

  @override
  // TODO: implement props
  List<Object?> get props => [passwordObscured, isLoading, errors];

  LoginState({
    this.passwordObscured,
    this.isLoading,
    this.errors
  });

  LoginState copyWith({
    bool? passwordObscured,
    bool? isLoading,
    Map<String, String?>? errors
  }) {
    return LoginState(
      passwordObscured: passwordObscured ?? this.passwordObscured,
      isLoading: isLoading ?? this.isLoading,
      errors: errors ?? this.errors
    );
  }
}
