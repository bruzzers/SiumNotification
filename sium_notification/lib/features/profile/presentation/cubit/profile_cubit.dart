import 'package:firebase_auth/firebase_auth.dart';
import 'package:sium_notification/core/state_management/base_cubit.dart';

import '../../repository/profile_repository.dart';

part 'profile_state.dart';

class ProfileCubit extends BaseCubit<ProfileState> {
  final ProfileRepository repository;
  ProfileCubit(this.repository) : super(ProfileState());

  Future<void> onInit() async{
    emit(state.copyWith(isLoading: true));

    final res = await repository.getCurrentUser();

    if(res != null){
      emit(state.copyWith(user: res));
    }

    emit(state.copyWith(isLoading: false));
  }
}
