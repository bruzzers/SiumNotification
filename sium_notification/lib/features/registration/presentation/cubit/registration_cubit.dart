import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sium_notification/core/state_management/base_cubit.dart';
import 'package:sium_notification/features/registration/repository/registration_repository.dart';
import 'package:sium_notification/utils/validator/fields_validator.dart';

part 'registration_state.dart';

class RegistrationCubit extends BaseCubit<RegistrationState> {
  final RegistrationRepository repository;
  final FieldsValidator fieldsValidator;
  late TextEditingController emailController;
  late TextEditingController pswController;
  late TextEditingController usernameController;

  RegistrationCubit(this.repository, this.fieldsValidator)
      : super(RegistrationState()) {
    emailController = TextEditingController()
      ..addListener(() {
        _validateEmail(emailController.text);
      });
    pswController = TextEditingController()
      ..addListener(() {
        _validatePsw(pswController.text);
      });
    usernameController = TextEditingController();
  }

  Future<void> registerUser() async {
    emit(state.copyWith(isLoading: true));
    final res = await repository.registerUser(
        emailController.text, pswController.text, usernameController.text);

    if (res.errorDetail == null) {
      Get.back();
    } else {
      Get.snackbar("Impossibile registrare l'utenza", res.errorDetail ?? "");
      emit(state.copyWith(isLoading: false));
    }
  }

  void _validateEmail(String? email) {
    Map<String, String?> map = {};
    state.errors?.forEach((key, value) {
      map.addAll({key: value});
    });
    if (fieldsValidator.isEmailValid(email ?? "")) {
      map.addAll({"email": null});
    } else {
      map.addAll({"email": "Email non valida"});
    }
    emit(state.copyWith(errors: map));
  }

  void _validatePsw(String? psw) {
    Map<String, String?> map = {};
    state.errors?.forEach((key, value) {
      map.addAll({key: value});
    });
    if (fieldsValidator.isPswValid(psw ?? "")) {
      map.addAll({"psw": null});
      emit(state.pswValid());
    } else {
      map.addAll({"psw": "Password non valida"});
      _setPswSpecificErrors(psw ?? "");
    }
    emit(state.copyWith(errors: map));
  }

  void _setPswSpecificErrors(String psw) {
    emit(state.copyWith(
        pswHas8Char: fieldsValidator.pswHas8Char(psw),
        pswHasUpperCase: fieldsValidator.pswHasUpperCase(psw),
        pswHasNumber: fieldsValidator.pswHasNumber(psw),
        pswHasSpecial: fieldsValidator.pswHasSpecialChar(psw),
        pswHasLowerCase: fieldsValidator.pswHasLowerCase(psw)));
  }

  void setVisibility() {
    emit(state.copyWith(passwordObscured: !(state.passwordObscured ?? true)));
  }

  Future<void> checkValuesAndRegister() async {
    if (state.ctaIsEnabled) {
      await registerUser();
    }
  }
}
