
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sium_notification/core/state_management/base_cubit.dart';
import 'package:sium_notification/features/login/data/login_repository.dart';
import 'package:sium_notification/utils/routes.dart';
import 'package:sium_notification/utils/validator/fields_validator.dart';

part 'login_state.dart';

class LoginCubit extends BaseCubit<LoginState> {
  final LoginRepository repository;
  final FieldsValidator fieldsValidator;

  late TextEditingController? emailController;
  late TextEditingController? pswController;
  LoginCubit(this.repository, this.fieldsValidator) : super(LoginState()){
    emailController = TextEditingController();
    pswController = TextEditingController();
  }

  void goToRegistration() {
    Get.toNamed(Routes.registration);
  }

  Future<void> signIn() async{
    final res = await repository.login(emailController?.text, pswController?.text);

    print(res.user.toString());
  }
}
