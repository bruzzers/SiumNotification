import 'package:firebase_auth/firebase_auth.dart';

abstract class RegistrationRepository{

  Future<UserCredential> registerUser(String? email, String? password);
}