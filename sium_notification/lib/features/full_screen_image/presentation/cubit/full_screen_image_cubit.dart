import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sium_notification/core/state_management/base_cubit.dart';

part 'full_screen_image_state.dart';

class FullScreenImageCubit extends BaseCubit<FullScreenImageState> {
  FullScreenImageCubit() : super(FullScreenImageState());

  void onInit(String? imageUrl){
    emit(state.copyWith(imageUrl: imageUrl));
  }
}
