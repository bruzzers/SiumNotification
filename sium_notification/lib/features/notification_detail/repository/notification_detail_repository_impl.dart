import 'package:firebase_auth/firebase_auth.dart';
import 'package:sium_notification/core/model/notification_model.dart';
import 'package:sium_notification/features/notification_detail/repository/notification_detail_repository.dart';
import 'package:sium_notification/utils/firebase/firebase_utils.dart';

class NotificationDetailRepositoryImpl extends NotificationDetailRepository{
  final FirebaseUtils firebaseUtils;

  NotificationDetailRepositoryImpl(this.firebaseUtils);

  @override
  Future<void> sendNotificationComment(String? comment, NotificationModel? model, int? selectedVote) async{
    await firebaseUtils.addNotificationComment(comment, model, selectedVote);
  }

  @override
  User? getCurrentUser() {
    return firebaseUtils.getCurrentUser();
  }
}