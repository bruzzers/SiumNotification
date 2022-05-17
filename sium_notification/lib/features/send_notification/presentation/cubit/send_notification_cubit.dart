import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:sium_notification/core/component/sium_text.dart';
import 'package:sium_notification/core/constants/text_styles.dart';
import 'package:sium_notification/core/state_management/base_cubit.dart';
import 'package:sium_notification/features/send_notification/repository/send_notification_repository.dart';

part 'send_notification_state.dart';

class SendNotificationCubit extends BaseCubit<SendNotificationState> {
  final SendNotificationRepository repository;

  late TextEditingController titleController;
  late TextEditingController floorController;
  late TextEditingController roomController;
  late TextEditingController noteController;
  SendNotificationCubit(this.repository) : super(SendNotificationState()){
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

  void updateSelectedOffice(String? value) {
    emit(state.copyWith(selectedOffice: value));
  }
}
