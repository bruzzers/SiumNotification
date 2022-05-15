part of 'profile_cubit.dart';

class ProfileState extends BaseState{
  final bool? isEditingEmail;
  final bool? isEditingPsw;
  final bool? isEditingUsername;
  final String? emailError;
  final String? pswError;
  final User? user;
  final bool? isLoading;
  final bool? passwordObscured;

  @override
  List<Object?> get props => [user, isLoading, isEditingEmail, isEditingPsw, isEditingUsername, passwordObscured, emailError, pswError];

  ProfileState({
    this.isEditingEmail,
    this.isEditingPsw,
    this.isEditingUsername,
    this.emailError,
    this.pswError,
    this.user,
    this.isLoading,
    this.passwordObscured,
  });

  ProfileState copyWith({
    bool? isEditingEmail,
    bool? isEditingPsw,
    bool? isEditingUsername,
    String? emailError,
    String? pswError,
    User? user,
    bool? isLoading,
    bool? passwordObscured,
  }) {
    return ProfileState(
      isEditingEmail: isEditingEmail ?? this.isEditingEmail,
      isEditingPsw: isEditingPsw ?? this.isEditingPsw,
      isEditingUsername: isEditingUsername ?? this.isEditingUsername,
      emailError: emailError ?? this.emailError,
      pswError: pswError ?? this.pswError,
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
      passwordObscured: passwordObscured ?? this.passwordObscured,
    );
  }

  ProfileState removeEmailError(){
    return ProfileState(
      isEditingEmail: isEditingEmail,
      isEditingPsw: isEditingPsw,
      isEditingUsername: isEditingUsername,
      emailError: null,
      pswError: pswError,
      user: user,
      isLoading: isLoading,
      passwordObscured: passwordObscured,
    );
  }

  ProfileState removePswError(){
    return ProfileState(
      isEditingEmail: isEditingEmail,
      isEditingPsw: isEditingPsw,
      isEditingUsername: isEditingUsername,
      emailError: emailError,
      pswError: null,
      user: user,
      isLoading: isLoading,
      passwordObscured: passwordObscured,
    );
  }
}
