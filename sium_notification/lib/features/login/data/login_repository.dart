import 'package:firebase_auth/firebase_auth.dart';

abstract class LoginRepository{
  Future<UserCredential?> login(String? email, String? password);
  Future<UserCredential> loginWithGoogle();
  Future<bool> isLoggedIn();
  User? getCurrentUser();
}