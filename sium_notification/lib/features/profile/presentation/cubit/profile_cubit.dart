import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sium_notification/core/state_management/base_cubit.dart';
import 'package:sium_notification/utils/di_service.dart';
import 'package:sium_notification/utils/routes.dart';
import 'package:sium_notification/utils/validator/fields_validator.dart';

import '../../repository/profile_repository.dart';

part 'profile_state.dart';

class ProfileCubit extends BaseCubit<ProfileState> {
  final ProfileRepository repository;
  final FieldsValidator fieldsValidator;
  late TextEditingController emailController;
  late TextEditingController usernameController;
  late TextEditingController pswController;

  ProfileCubit(this.repository, this.fieldsValidator) : super(ProfileState()){
    emailController = TextEditingController();
    usernameController = TextEditingController();
    pswController = TextEditingController();
  }

  Future<void> onInit() async{
    emit(state.copyWith(isLoading: true));

    final res = await repository.getCurrentUser();

    if(res != null){
      emit(state.copyWith(user: res));
      emailController.text = res.email ?? "";
      usernameController.text = res.displayName ?? res.email ?? "";
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

  Future<void> updateEmail() async{
    emit(state.copyWith(isLoading: true));

    if(validator.isEmailValid(emailController.text)){
      emit(state.removeEmailError());

      final res = await repository.updateEmail(emailController.text);
      if(res){
        emit(state.copyWith(isEditingEmail: false));
        await onInit();
      }else{
        Get.snackbar("Errore", "Impossibile modificare l'email, riprovare più tardi");
      }
    }else{
      emit(state.copyWith(emailError: "Email non valida"));
    }

    emit(state.copyWith(isLoading: false));
  }

  Future<void> updateUsername() async{
    emit(state.copyWith(isLoading: true));

    final res = await repository.updateUsername(usernameController.text);

    if(res){
      emit(state.copyWith(isEditingUsername: false));
      await onInit();
    }else{
      Get.snackbar("Errore", "Impossibile modificare l'username, riprovare più tardi");
    }
    emit(state.copyWith(isLoading: false));
  }

  Future<void> updatePassword() async{
    emit(state.copyWith(isLoading: true));

    if(validator.isPswValid(pswController.text)){
      emit(state.removePswError());

      final res = await repository.updatePassword(pswController.text);

      if(res){
        emit(state.copyWith(isEditingPsw: false));
        await onInit();
      }else{
        Get.snackbar("Errore", "Impossibile modificare la password, riprovare più tardi");
      }
    }else{
      emit(state.copyWith(pswError: "Password non valida"));
    }

    emit(state.copyWith(isLoading: false));
  }

  Future<void> logout() async{
    await repository.logout();

    Get.offAllNamed(Routes.login);
  }

  void setPasswordVisibility() {
    emit(state.copyWith(passwordObscured: !(state.passwordObscured ?? true)));
  }
}
