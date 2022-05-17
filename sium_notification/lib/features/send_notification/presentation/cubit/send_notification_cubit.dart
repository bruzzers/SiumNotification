import 'package:flutter/material.dart';
import 'package:sium_notification/core/component/sium_text.dart';
import 'package:sium_notification/core/constants/text_styles.dart';
import 'package:sium_notification/core/model/notification_model.dart';
import 'package:sium_notification/core/state_management/base_cubit.dart';
import 'package:sium_notification/features/send_notification/repository/send_notification_repository.dart';
import 'package:sium_notification/utils/date/date_utils.dart';

part 'send_notification_state.dart';

class SendNotificationCubit extends BaseCubit<SendNotificationState> {
  final SendNotificationRepository repository;
  final SiumDateUtils dateUtils;

  late TextEditingController titleController;
  late TextEditingController floorController;
  late TextEditingController roomController;
  late TextEditingController noteController;
  SendNotificationCubit(this.repository, this.dateUtils) : super(SendNotificationState()){
    titleController = TextEditingController()..addListener(() {
      emit(state.copyWith(ctaActive: titleController.text.isNotEmpty));
    });
    floorController = TextEditingController();
    roomController = TextEditingController();
    noteController = TextEditingController();
  }

  Future<void> onInit() async{
    emit(state.copyWith(selectedOffice: "Milano", offices: _getOfficesList()));
  }

  List<DropdownMenuItem<String>> _getOfficesList(){
    return const [
      DropdownMenuItem<String>(child: SiumText("Milano", style: sium12Regular,), value: "Milano",),
      DropdownMenuItem<String>(child: SiumText("Treviso", style: sium12Regular,),value: "Treviso"),
      DropdownMenuItem<String>(child: SiumText("Cosenza", style: sium12Regular,),value: "Cosenza"),
      DropdownMenuItem<String>(child: SiumText("Roma", style: sium12Regular,),value: "Roma"),
      DropdownMenuItem<String>(child: SiumText("Napoli", style: sium12Regular,),value: "Napoli"),
      DropdownMenuItem<String>(child: SiumText("Torino", style: sium12Regular,),value: "Torino"),
      DropdownMenuItem<String>(child: SiumText("Genova", style: sium12Regular,),value: "Genova"),
      DropdownMenuItem<String>(child: SiumText("Bari", style: sium12Regular,),value: "Bari"),
      DropdownMenuItem<String>(child: SiumText("Salerno", style: sium12Regular,),value: "Salerno"),
    ];
  }

  Future<void> sendNotification() async{
    emit(state.copyWith(isLoading: true));

    final user = repository.getCurrentUser();
    final model = NotificationModel(
      title: titleController.text,
      sentBy: user?.displayName ?? user?.email,
      sentByUid: user?.uid,
      date: dateUtils.getNowDate(),
      floor: floorController.text,
      room: roomController.text,
      note: noteController.text,
      position: state.selectedOffice
    );

    final res = await repository.sendNotification(model);

    titleController.text = "";
    floorController.text = "";
    roomController.text = "";
    noteController.text = "";
    emit(state.copyWith(selectedOffice: "Milano"));

    emit(state.copyWith(isLoading: false));
  }

  void updateSelectedOffice(String? value) {
    emit(state.copyWith(selectedOffice: value));
  }
}
