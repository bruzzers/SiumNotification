import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sium_notification/core/state_management/base_cubit.dart';

part 'home_state.dart';

class HomeCubit extends BaseCubit<HomeState> {
  HomeCubit() : super(HomeState());
}
