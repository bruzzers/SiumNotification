// coverage:ignore-file
import 'package:get/get.dart';
import 'package:sium_notification/features/login/data/login_repository.dart';
import 'package:sium_notification/features/login/data/login_repository_impl.dart';

Future<void> init() async{
  Get.put<LoginRepository>(LoginRepositoryImpl());
}

LoginRepository get loginRepo => Get.find<LoginRepository>();