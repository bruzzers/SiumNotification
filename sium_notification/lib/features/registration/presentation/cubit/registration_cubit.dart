import 'package:flutter/cupertino.dart';
import 'package:sium_notification/core/state_management/base_cubit.dart';
import 'package:sium_notification/features/registration/repository/registration_repository.dart';

part 'registration_state.dart';

class RegistrationCubit extends BaseCubit<RegistrationState> {
  final RegistrationRepository repository;

  late TextEditingController emailController;
  late TextEditingController pswController;

  RegistrationCubit(this.repository) : super(RegistrationState()){
    emailController = TextEditingController();
    pswController = TextEditingController();
  }

  Future<void> registerUser() async{
    final res = await repository.registerUser(emailController.text, pswController.text);

    print(res.toString());
  }
}
