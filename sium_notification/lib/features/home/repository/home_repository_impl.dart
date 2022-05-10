import 'package:sium_notification/core/model/notification_model.dart';
import 'package:sium_notification/features/home/repository/home_repository.dart';
import 'package:sium_notification/utils/firebase/firebase_utils.dart';

class HomeRepositoryImpl extends HomeRepository{
  final FirebaseUtils firebaseUtils;

  HomeRepositoryImpl(this.firebaseUtils);

  @override
  Future<List<NotificationModel>> getNotifications() async{
    final res = await firebaseUtils.getNotificationList();

    return res;
  }
}