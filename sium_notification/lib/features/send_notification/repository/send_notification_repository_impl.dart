import 'package:firebase_auth/firebase_auth.dart';
import 'package:sium_notification/core/model/notification_model.dart';
import 'package:sium_notification/features/send_notification/repository/send_notification_repository.dart';
import 'package:sium_notification/utils/firebase/firebase_utils.dart';

class SendNotificationRepositoryImpl extends SendNotificationRepository{
  final FirebaseUtils firebaseUtils;

  SendNotificationRepositoryImpl(this.firebaseUtils);

  @override
  Future<void> sendNotification(NotificationModel model) async{
    await firebaseUtils.sendNotification(model);
  }

  @override
  User? getCurrentUser() {
    return firebaseUtils.getCurrentUser();
  }
}