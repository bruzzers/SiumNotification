import 'package:firebase_auth/firebase_auth.dart';

abstract class NotificationDetailRepository{
  Future<void> sendNotificationComment(String? comment, String? id);
  User? getCurrentUser();
}