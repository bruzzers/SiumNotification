import 'package:sium_notification/core/model/notification_model.dart';

abstract class OwnNotificationRepository {
  Future<List<NotificationModel>> getOwnNotification();
  Future<void> deleteNotification(NotificationModel? model);
}