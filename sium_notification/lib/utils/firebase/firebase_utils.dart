import 'package:firebase_auth/firebase_auth.dart';

abstract class FirebaseUtils{
  Future<UserCredential> registerUser(String? email, String? password);
}