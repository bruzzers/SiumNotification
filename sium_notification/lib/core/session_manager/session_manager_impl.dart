// coverage:ignore-file
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sium_notification/core/session_manager/session_manager.dart';

class SessionManagerImpl extends SessionManager{
  User? _user;
  @override
  void saveUser(UserCredential? user) {
    _user = user?.user;
  }

  @override
  User? getUser() {
    return _user;
  }

}