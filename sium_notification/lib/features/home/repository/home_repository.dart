import 'package:sium_notification/core/model/notification_model.dart';

abstract class HomeRepository{
  Future<List<NotificationModel>> getNotifications();
}