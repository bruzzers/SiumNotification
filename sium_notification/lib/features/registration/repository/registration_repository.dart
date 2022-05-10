import 'package:sium_notification/core/model/user_model.dart';

abstract class RegistrationRepository{

  Future<UserModel> registerUser(String? email, String? password, String? username);
}