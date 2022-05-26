import 'package:sium_notification/core/model/notification_model.dart';
import 'package:sium_notification/features/own_notification/repository/own_notification_repository.dart';
import 'package:sium_notification/utils/firebase/firebase_utils.dart';

class OwnNotificationRepositoryImpl extends OwnNotificationRepository{
  final FirebaseUtils firebaseUtils;

  OwnNotificationRepositoryImpl(this.firebaseUtils);

  @override
  Future<List<NotificationModel>> getOwnNotification() async{
    return await firebaseUtils.getOwnNotifiationList();
  }

  @override
  Future<void> deleteNotification(NotificationModel? model) async{
    return await firebaseUtils.deleteNotification(model);
  }



}