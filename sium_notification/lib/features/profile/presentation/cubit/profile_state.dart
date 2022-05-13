part of 'profile_cubit.dart';

class ProfileState extends BaseState{
  final bool? isEditingEmail;
  final bool? isEditingPsw;
  final bool? isEditingUsername;
  final User? user;
  final bool? isLoading;
  @override
  // TODO: implement props
  List<Object?> get props => [user, isLoading, isEditingEmail, isEditingPsw, isEditingUsername];

  ProfileState({
    this.isEditingEmail,
    this.isEditingPsw,
    this.isEditingUsername,
    this.user,
    this.isLoading,
  });

  ProfileState copyWith({
    bool? isEditingEmail,
    bool? isEditingPsw,
    bool? isEditingUsername,
    User? user,
    bool? isLoading,
  }) {
    return ProfileState(
      isEditingEmail: isEditingEmail ?? this.isEditingEmail,
      isEditingPsw: isEditingPsw ?? this.isEditingPsw,
      isEditingUsername: isEditingUsername ?? this.isEditingUsername,
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
