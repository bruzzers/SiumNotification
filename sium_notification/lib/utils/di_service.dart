// coverage:ignore-file
import 'package:get/get.dart';
import 'package:sium_notification/core/service/local_notification_service.dart';
import 'package:sium_notification/core/session_manager/session_manager.dart';
import 'package:sium_notification/core/session_manager/session_manager_impl.dart';
import 'package:sium_notification/features/home/repository/home_repository.dart';
import 'package:sium_notification/features/home/repository/home_repository_impl.dart';
import 'package:sium_notification/features/login/data/login_repository.dart';
import 'package:sium_notification/features/login/data/login_repository_impl.dart';
import 'package:sium_notification/features/profile/repository/profile_repository.dart';
import 'package:sium_notification/features/profile/repository/profile_repository_impl.dart';
import 'package:sium_notification/features/registration/repository/registration_repository.dart';
import 'package:sium_notification/features/registration/repository/registration_repository_impl.dart';
import 'package:sium_notification/utils/date/date_utils.dart';
import 'package:sium_notification/utils/date/date_utils_impl.dart';
import 'package:sium_notification/utils/firebase/firebase_utils.dart';
import 'package:sium_notification/utils/firebase/firebase_utils_impl.dart';
import 'package:sium_notification/utils/validator/fields_validator.dart';
import 'package:sium_notification/utils/validator/fields_validator_impl.dart';

Future<void> init() async{
  Get.put<FirebaseUtils>(FirebaseUtilsImpl());
  Get.put<LoginRepository>(LoginRepositoryImpl(firebaseUtils));
  Get.put<RegistrationRepository>(RegistrationRepositoryImpl(firebaseUtils));
  Get.put<FieldsValidator>(FieldsValidatorImpl());
  Get.put<SessionManager>(SessionManagerImpl());
  Get.put<HomeRepository>(HomeRepositoryImpl(firebaseUtils));
  Get.put<ProfileRepository>(ProfileRepositoryImpl(firebaseUtils));
  Get.put<DateUtils>(DateUtilsImpl());
  Get.put<LocalNotificationService>(LocalNotificationServiceImpl());
}

FirebaseUtils get firebaseUtils => Get.find<FirebaseUtils>();
LoginRepository get loginRepo => Get.find<LoginRepository>();
RegistrationRepository get registrationRepo => Get.find<RegistrationRepository>();
FieldsValidator get validator => Get.find<FieldsValidator>();
SessionManager get sessionManager => Get.find<SessionManager>();
HomeRepository get homeRepo => Get.find<HomeRepository>();
ProfileRepository get profileRepo => Get.find<ProfileRepository>();
DateUtils get dateUtils => Get.find<DateUtils>();
LocalNotificationService get localNotificationService => Get.find<LocalNotificationService>();