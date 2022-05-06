import 'dart:async';

import 'package:get/route_manager.dart';
import 'package:sium_notification/core/state_management/base_cubit.dart';
import 'package:sium_notification/utils/routes.dart';

part 'splash_state.dart';

class SplashCubit extends BaseCubit<SplashState> {
  SplashCubit() : super(SplashState());

  Future<void> onInit() async{
    Timer(const Duration(seconds: 2), (){
      Get.offAndToNamed(Routes.login);
    });
  }
}
