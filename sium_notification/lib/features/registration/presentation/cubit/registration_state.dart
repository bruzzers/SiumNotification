part of 'registration_cubit.dart';

class RegistrationState extends BaseState{
  final Map<String, String?>? errors;
  final bool? passwordObscured;
  final bool? isLoading;
  final bool? pswHas8Char;
  final bool? pswHasUpperCase;
  final bool? pswHasLowerCase;
  final bool? pswHasSpecial;
  final bool? pswHasNumber;

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
  List<Object?> get props => [isLoading, errors, passwordObscured, pswHas8Char, pswHasLowerCase, pswHasNumber, pswHasSpecial, pswHasUpperCase];

  RegistrationState({
    this.errors,
    this.passwordObscured,
    this.isLoading,
    this.pswHas8Char,
    this.pswHasUpperCase,
    this.pswHasLowerCase,
    this.pswHasSpecial,
    this.pswHasNumber,
  });

  RegistrationState copyWith({
    Map<String, String?>? errors,
    bool? passwordObscured,
    bool? isLoading,
    bool? pswHas8Char,
    bool? pswHasUpperCase,
    bool? pswHasLowerCase,
    bool? pswHasSpecial,
    bool? pswHasNumber,
  }) {
    return RegistrationState(
      errors: errors ?? this.errors,
      passwordObscured: passwordObscured ?? this.passwordObscured,
      isLoading: isLoading ?? this.isLoading,
      pswHas8Char: pswHas8Char ?? this.pswHas8Char,
      pswHasUpperCase: pswHasUpperCase ?? this.pswHasUpperCase,
      pswHasLowerCase: pswHasLowerCase ?? this.pswHasLowerCase,
      pswHasSpecial: pswHasSpecial ?? this.pswHasSpecial,
      pswHasNumber: pswHasNumber ?? this.pswHasNumber,
    );
  }

  RegistrationState pswValid() {
    return RegistrationState(
      errors: errors,
      passwordObscured: passwordObscured,
      isLoading: isLoading,
      pswHas8Char: true,
      pswHasLowerCase: true,
      pswHasNumber: true,
      pswHasSpecial: true,
      pswHasUpperCase: true
    );
  }
}
