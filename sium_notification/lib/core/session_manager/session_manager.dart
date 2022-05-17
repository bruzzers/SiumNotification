// coverage:ignore-file
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sium_notification/core/model/credential_model.dart';

abstract class SessionManager{
  void saveUser(User? user);
  void saveCredential(String? email, String? password);
  User? getUser();
  Future<CredentialModel?> getCredential();
  Future<void> updateEmail(String? email);
  Future<void> updatePsw(String? psw);
  Future<void> logout();
}