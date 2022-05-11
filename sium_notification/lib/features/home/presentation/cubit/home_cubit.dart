import 'package:bloc/bloc.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:sium_notification/core/model/notification_model.dart';
import 'package:sium_notification/core/session_manager/session_manager.dart';
import 'package:sium_notification/core/state_management/base_cubit.dart';
import 'package:sium_notification/features/home/repository/home_repository.dart';
import 'package:sium_notification/utils/di_service.dart';

part 'home_state.dart';

class HomeCubit extends BaseCubit<HomeState> {
  final HomeRepository repository;
  final SessionManager sessionManager;
  HomeCubit(this.repository, this.sessionManager) : super(HomeState());

  Future<void> onInit() async{
    emit(state.copyWith(isLoading: true));
    emit(state.copyWith(visibleName: sessionManager.getUser()?.displayName ?? sessionManager.getUser()?.email));
    final res = await repository.getNotifications();

    if(res.isNotEmpty){
      res.sort((a, b) {
        return dateUtils.parseStringDate(b.date)?.compareTo(dateUtils.parseStringDate(a.date) ?? "") ?? 0;
      });
      emit(state.copyWith(notifications: res));
    }else{
      // showDialog
    }
    emit(state.copyWith(isLoading: false));
  }
}
