// coverage:ignore-file
import 'dart:convert';
import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sium_notification/core/model/credential_model.dart';
import 'package:sium_notification/core/session_manager/session_manager.dart';

class SessionManagerImpl extends SessionManager{
  User? _user;
  @override
  void saveUser(User? user) {
    _user = user;
  }

  @override
  User? getUser() {
    return _user;
  }

  @override
  Future<CredentialModel?> getCredential() async{
    final pref = EncryptedSharedPreferences();
    final email = await pref.getString("email");
    final psw = await pref.getString("psw");
    return CredentialModel(
      email: email,
      password: psw
    );
  }

  @override
  void saveCredential(String? email, String? password) async{
    final pref = EncryptedSharedPreferences();

    await pref.setString("email", email ?? "");
    await pref.setString("psw", password ?? "");
  }

  @override
  Future<void> updateEmail(String? email) async{
    final pref = EncryptedSharedPreferences();

    await pref.setString("email", email ?? "");
  }

  @override
  Future<void> updatePsw(String? psw) async{
    final pref = EncryptedSharedPreferences();

    await pref.setString("psw", psw ?? "");
  }

  @override
  Future<void> logout() async{
    final pref = EncryptedSharedPreferences();

    await pref.clear();
  }

}