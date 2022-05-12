part of 'profile_cubit.dart';

class ProfileState extends BaseState{
  final User? user;
  final bool? isLoading;
  @override
  // TODO: implement props
  List<Object?> get props => [user, isLoading];

  ProfileState({
    this.user,
    this.isLoading,
  });

  ProfileState copyWith({
    User? user,
    bool? isLoading,
  }) {
    return ProfileState(
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
