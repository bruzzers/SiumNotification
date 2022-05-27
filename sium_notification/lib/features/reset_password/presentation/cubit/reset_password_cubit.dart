import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:sium_notification/core/state_management/base_cubit.dart';
import 'package:sium_notification/features/reset_password/repository/reset_password_repository.dart';
import 'package:sium_notification/utils/validator/fields_validator.dart';

part 'reset_password_state.dart';

class ResetPasswordCubit extends BaseCubit<ResetPasswordState> {
  final FieldsValidator fieldsValidator;
  final ResetPasswordRepository repository;

  late TextEditingController emailController;
  ResetPasswordCubit(this.repository, this.fieldsValidator) : super(ResetPasswordState()){
    emailController = TextEditingController()..addListener(() {
      _validateEmail(emailController.text);
    });
  }

  void _validateEmail(String? email){
    if(fieldsValidator.isEmailValid(email ?? "")){
      emit(state.removeEmailError());
    }else{
      emit(state.copyWith(emailError: "Email non valida"));
    }
  }

  Future<void> resetPassword() async{
    emit(state.copyWith(isLoading: true));

    final res = await repository.resetPassword(emailController.text);

    if(res){
      Get.back();
    }else{
      Get.snackbar("Impossibile resettare la password", "Sembra che la mail non sia corretta");
    }

    emit(state.copyWith(isLoading: false));
  }
}
