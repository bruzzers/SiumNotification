import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
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

  void setEditEmail(bool editing){
    emit(state.copyWith(isEditingEmail: editing));
  }

  void setEditUsername(bool editing){
    emit(state.copyWith(isEditingUsername: editing));
  }

  void setEditPassword(bool editing){
    emit(state.copyWith(isEditingPsw: editing));
  }

  Future<void> updateEmail(String? email) async{
    emit(state.copyWith(isLoading: true));

    final res = await repository.updateEmail(email);

    if(res){
      await onInit();
    }else{
      Get.snackbar("Errore", "Impossibile modificare l'email, riprovare più tardi");
      emit(state.copyWith(isLoading: false));
    }
  }

  Future<void> updateUsername(String? username) async{

  }

  Future<void> updatePassword(String? password) async{

  }
}
