import 'package:sium_notification/features/registration/repository/registration_repository.dart';
import 'package:sium_notification/utils/firebase/firebase_utils.dart';

import '../../../core/model/user_model.dart';

class RegistrationRepositoryImpl extends RegistrationRepository{
  final FirebaseUtils firebase;

  RegistrationRepositoryImpl(this.firebase);

  @override
  Future<UserModel> registerUser(String? email, String? password, String? username) async{
    final res = await firebase.registerUser(email, password, username);

    return res;
  }

}