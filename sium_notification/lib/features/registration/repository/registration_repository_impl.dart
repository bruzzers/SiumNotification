import 'package:firebase_auth/firebase_auth.dart';
import 'package:sium_notification/features/registration/repository/registration_repository.dart';
import 'package:sium_notification/utils/firebase/firebase_utils.dart';

class RegistrationRepositoryImpl extends RegistrationRepository{
  final FirebaseUtils firebase;

  RegistrationRepositoryImpl(this.firebase);

  @override
  Future<UserCredential> registerUser(String? email, String? password) async{
    final res = await firebase.registerUser(email, password);

    print("Firebase Res: ${res.toString()}");
    return res;
  }

}