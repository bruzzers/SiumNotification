import 'package:firebase_auth/firebase_auth.dart';
import 'package:sium_notification/core/model/notification_model.dart';

abstract class SendNotificationRepository {

  Future<void> sendNotification(NotificationModel model);
  User? getCurrentUser();
}