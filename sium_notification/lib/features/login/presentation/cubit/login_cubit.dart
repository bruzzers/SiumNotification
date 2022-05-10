
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
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

  late TextEditingController? emailController;
  late TextEditingController? pswController;
  LoginCubit(this.repository, this.fieldsValidator, this.sessionManager) : super(LoginState()){
    emailController = TextEditingController();
    pswController = TextEditingController();
  }

  void onInit() async{
    final res = await repository.isLoggedIn();

    if(res){
      print("Sono loggato");
    }else{
      print("Non sono loggato");
    }
  }

  void goToRegistration() {
    Get.toNamed(Routes.registration);
  }

  Future<void> signIn() async{
    emit(state.copyWith(isLoading: true));
    final res = await repository.login(emailController?.text, pswController?.text);

    print(res.user.toString());
    emit(state.copyWith(isLoading: false));
  }

  Future<void> signInWithGoogle() async{
    final res = await repository.loginWithGoogle();

    print(res.user.toString());
  }

  void setVisibility() {
    emit(state.copyWith(passwordObscured: !(state.passwordObscured ?? true)));
  }
}
