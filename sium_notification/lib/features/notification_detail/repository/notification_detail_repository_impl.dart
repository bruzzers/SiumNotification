import 'package:firebase_auth/firebase_auth.dart';
import 'package:sium_notification/features/notification_detail/repository/notification_detail_repository.dart';
import 'package:sium_notification/utils/firebase/firebase_utils.dart';

class NotificationDetailRepositoryImpl extends NotificationDetailRepository{
  final FirebaseUtils firebaseUtils;

  NotificationDetailRepositoryImpl(this.firebaseUtils);

  @override
  Future<void> sendNotificationComment(String? comment, String? id) async{
    await firebaseUtils.addNotificationComment(comment, id);
  }

  @override
  User? getCurrentUser() {
    return firebaseUtils.getCurrentUser();
  }
}