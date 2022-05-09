part of 'registration_cubit.dart';

class RegistrationState extends BaseState{
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
  List<Object?> get props => [isLoading, errors];

  RegistrationState({
    this.errors,
    this.isLoading
  });

  RegistrationState copyWith({
    Map<String, String?>? errors,
    bool? isLoading,
    bool? ctaIsEnabled,
  }) {
    return RegistrationState(
      errors: errors ?? this.errors,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
