part of 'registration_cubit.dart';

class RegistrationState extends BaseState{
  final Map<String, String?>? errors;
  final bool? passwordObscured;
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
  List<Object?> get props => [isLoading, errors, passwordObscured];

  RegistrationState({
    this.errors,
    this.isLoading,
    this.passwordObscured
  });

  RegistrationState copyWith({
    Map<String, String?>? errors,
    bool? passwordObscured,
    bool? isLoading,
  }) {
    return RegistrationState(
      errors: errors ?? this.errors,
      passwordObscured: passwordObscured ?? this.passwordObscured,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
