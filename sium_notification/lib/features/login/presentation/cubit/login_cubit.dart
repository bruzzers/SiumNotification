import 'dart:io';

import 'package:android_power_manager/android_power_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import 'package:sium_notification/core/session_manager/session_manager.dart';
import 'package:sium_notification/core/state_management/base_cubit.dart';
import 'package:sium_notification/features/login/data/login_repository.dart';
import 'package:sium_notification/utils/routes.dart';
import 'package:sium_notification/utils/validator/fields_validator.dart';

part 'login_state.dart';

class LoginCubit extends BaseCubit<LoginState> {
  final LoginRepository repository;
  final FieldsValidator fieldsValidator;
  final SessionManager sessionManager;

  late TextEditingController emailController;
  late TextEditingController pswController;
  LoginCubit(this.repository, this.fieldsValidator, this.sessionManager) : super(LoginState()){
    emailController = TextEditingController()..addListener(() {
      _validateEmail(emailController.text);
    });
    pswController = TextEditingController()..addListener(() {
      _validatePsw(pswController.text);
    });
  }

  void onInit() async{
    emit(state.copyWith(errors: {}));
    final res = await repository.isLoggedIn();

    if(res) {
      final canBio = await LocalAuthentication().canCheckBiometrics;
      final bioList = await LocalAuthentication().getAvailableBiometrics();

      final credential = await sessionManager.getCredential();
      if (credential?.email != null && credential?.password != null) {
        if (canBio && bioList.isNotEmpty) {
          final authorized = await LocalAuthentication().authenticate(
              localizedReason: "Scan fingerprint",
              options: const AuthenticationOptions(useErrorDialogs: true,
                stickyAuth: true,
                biometricOnly: true,));
          if (authorized) {
            final res = await repository.login(credential?.email, credential?.password);
            if(res?.user?.emailVerified == true) {
              sessionManager.saveUser(repository.getCurrentUser());
              Get.offAndToNamed(Routes.main);
            }else{
              Get.snackbar("Impossibile effettuare l'accesso", "Conferma la registrazione sulla tua mail");
            }
          } else {
            print(
                "Sarei loggato ma non ?? stato possibile confrontare il biometrico");
          }
        } else {
          print("Impossibile controllare il biometrico");
        }
      } else {
        print("Non sono loggato");
      }
    }else{
      print("Non sono loggato");
    }
  }

  void goToRegistration() {
    Get.toNamed(Routes.registration);
  }

  Future<void> signIn() async{
    emit(state.copyWith(isLoading: true));
    final res = await repository.login(emailController.text, pswController.text);

    if(res != null) {
      if (res.user != null) {
        if (res.user?.emailVerified == true) {
          sessionManager.saveUser(res.user);
          sessionManager.saveCredential(
              emailController.text, pswController.text);
          Get.offAndToNamed(Routes.main);
        } else {
          Get.snackbar("Impossibile effettuare l'accesso",
              "Conferma la registrazione sulla tua mail");
        }
      }
    }else{
      Get.snackbar("Impossibile effettuare l'accesso", "Username o Password errati");
    }
    emit(state.copyWith(isLoading: false));
  }

  Future<void> signInWithGoogle() async{
    final res = await repository.loginWithGoogle();

    print(res.user.toString());
  }

  void setVisibility() {
    emit(state.copyWith(passwordObscured: !(state.passwordObscured ?? true)));
  }

  void _validateEmail(String? email){
    Map<String, String?> map = {};
    state.errors?.forEach((key, value) {
      map.addAll({key: value});
    });
    if(fieldsValidator.isEmailValid(email ?? "")){
      map.addAll({"email": null});
    }else{
      map.addAll({"email": "Email non valida"});
    }
    emit(state.copyWith(errors: map));
  }

  void _validatePsw(String? psw){
    Map<String, String?> map = {};
    state.errors?.forEach((key, value) {
      map.addAll({key: value});
    });
    if(fieldsValidator.isPswValid(psw ?? "")){
      map.addAll({"psw": null});
    }else{
      map.addAll({"psw": "Password non valida"});
    }
    emit(state.copyWith(errors: map));
  }

  Future<void> checkValuesAndLogin() async{
    if(state.ctaIsEnabled){
      await signIn();
    }
  }

  Future<void> goToResetPassword() async{
    Get.toNamed(Routes.resetPassword);
  }
}
