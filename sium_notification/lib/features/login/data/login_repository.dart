import 'package:firebase_auth/firebase_auth.dart';

abstract class LoginRepository{
  Future<UserCredential> login(String? email, String? password);
  Future<UserCredential> loginWithCredential(AuthCredential credential);
  Future<UserCredential> loginWithGoogle();
  Future<bool> isLoggedIn();
  User? getCurrentUser();
}