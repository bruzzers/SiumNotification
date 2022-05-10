import 'package:bloc/bloc.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:sium_notification/core/model/notification_model.dart';
import 'package:sium_notification/core/state_management/base_cubit.dart';
import 'package:sium_notification/features/home/repository/home_repository.dart';

part 'home_state.dart';

class HomeCubit extends BaseCubit<HomeState> {
  final HomeRepository repository;
  HomeCubit(this.repository) : super(HomeState());

  Future<void> onInit() async{
    emit(state.copyWith(isLoading: true));
    final res = await repository.getNotifications();

    if(res.isNotEmpty){
      emit(state.copyWith(notifications: res));
    }else{
      // showDialog
    }
    emit(state.copyWith(isLoading: false));
  }
}
