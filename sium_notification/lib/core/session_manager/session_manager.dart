// coverage:ignore-file
import 'package:firebase_auth/firebase_auth.dart';

abstract class SessionManager{
  void saveUser(User? user);
  User? getUser();
}