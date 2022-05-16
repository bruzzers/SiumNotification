import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';

abstract class ProfileRepository{
  Future<User?> getCurrentUser();
  Future<bool> updateEmail(String? email);
  Future<bool> updateUsername(String? username);
  Future<bool> updatePassword(String? password);
  Future<void> logout();
  Future<void> addImage(File profileImage);
}