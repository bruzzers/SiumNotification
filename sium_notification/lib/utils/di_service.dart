// coverage:ignore-file
import 'package:get/get.dart';
import 'package:sium_notification/features/login/data/login_repository.dart';
import 'package:sium_notification/features/login/data/login_repository_impl.dart';
import 'package:sium_notification/features/registration/repository/registration_repository.dart';
import 'package:sium_notification/features/registration/repository/registration_repository_impl.dart';
import 'package:sium_notification/utils/firebase/firebase_utils.dart';
import 'package:sium_notification/utils/firebase/firebase_utils_impl.dart';
import 'package:sium_notification/utils/validator/fields_validator.dart';
import 'package:sium_notification/utils/validator/fields_validator_impl.dart';

Future<void> init() async{
  Get.put<FirebaseUtils>(FirebaseUtilsImpl());
  Get.put<LoginRepository>(LoginRepositoryImpl(firebaseUtils));
  Get.put<RegistrationRepository>(RegistrationRepositoryImpl(firebaseUtils));
  Get.put<FieldsValidator>(FieldsValidatorImpl());
}

FirebaseUtils get firebaseUtils => Get.find<FirebaseUtils>();
LoginRepository get loginRepo => Get.find<LoginRepository>();
RegistrationRepository get registrationRepo => Get.find<RegistrationRepository>();
FieldsValidator get validator => Get.find<FieldsValidator>();