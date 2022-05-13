import 'package:firebase_auth/firebase_auth.dart';

abstract class ProfileRepository{
  Future<User?> getCurrentUser();
  Future<bool> updateEmail(String? email);
}