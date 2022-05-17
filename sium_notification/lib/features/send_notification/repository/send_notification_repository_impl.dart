import 'package:sium_notification/features/send_notification/repository/send_notification_repository.dart';
import 'package:sium_notification/utils/firebase/firebase_utils.dart';

class SendNotificationRepositoryImpl extends SendNotificationRepository{
  final FirebaseUtils firebaseUtils;

  SendNotificationRepositoryImpl(this.firebaseUtils);
}