import 'package:firebase_auth/firebase_auth.dart';
import 'package:sium_notification/core/model/user_model.dart';

abstract class FirebaseUtils{
  Future<UserModel> registerUser(String? email, String? password, String? username);
  Future<UserCredential> login(String? email, String? password);
  Future<UserCredential> signInWithGoogle();
  Future<bool> checkLoggedIn();
}