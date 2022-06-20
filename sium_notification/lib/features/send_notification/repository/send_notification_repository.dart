import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sium_notification/core/model/notification_model.dart';

abstract class SendNotificationRepository {

  Future<void> sendNotification(NotificationModel model);
  User? getCurrentUser();
  Future<String?> addImageToDb(XFile? file);
  Future<bool> removeImageFromDb(String? url);
}