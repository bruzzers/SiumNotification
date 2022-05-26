import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:sium_notification/core/model/notification_model.dart';
import 'package:sium_notification/core/model/user_model.dart';

abstract class FirebaseUtils{
  Future<UserModel> registerUser(String? email, String? password, String? username);
  Future<UserCredential> login(String? email, String? password);
  Future<UserCredential> loginWithCredential(AuthCredential credential);
  Future<UserCredential> signInWithGoogle();
  Future<bool> checkLoggedIn();
  Future<List<NotificationModel>> getNotificationList();
  Future<List<NotificationModel>> getOwnNotifiationList();
  User? getCurrentUser();
  Future<bool> editEmail(String? email);
  Future<bool> editUsername(String? username);
  Future<bool> editPassword(String? password);
  Future<void> logout();
  Future<void> editProfileImage(File profileImage);
  Future<void> sendNotification(NotificationModel model);
  Future<void> registerToAllTopic();
  Future<void> addNotificationComment(String? comment, String? id, int? selectedVote);
  Future<void> deleteNotification(NotificationModel? model);
}