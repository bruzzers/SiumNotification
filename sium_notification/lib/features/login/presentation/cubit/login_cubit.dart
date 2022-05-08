
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sium_notification/core/state_management/base_cubit.dart';
import 'package:sium_notification/features/login/data/login_repository.dart';
import 'package:sium_notification/utils/routes.dart';

part 'login_state.dart';

class LoginCubit extends BaseCubit<LoginState> {
  final LoginRepository repository;

  late TextEditingController? emailController;
  late TextEditingController? pswController;
  LoginCubit(this.repository) : super(LoginState()){
    emailController = TextEditingController();
    pswController = TextEditingController();
  }

  void goToRegistration() {
    Get.toNamed(Routes.registration);
  }
}
