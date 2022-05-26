import 'package:firebase_auth/firebase_auth.dart';
import 'package:sium_notification/core/model/notification_model.dart';

abstract class NotificationDetailRepository{
  Future<void> sendNotificationComment(String? comment, NotificationModel? model, int? selectedVote);
  User? getCurrentUser();
}