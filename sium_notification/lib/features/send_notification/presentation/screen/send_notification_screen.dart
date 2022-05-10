// coverage:ignore-file
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sium_notification/features/send_notification/presentation/cubit/send_notification_cubit.dart';

class SendNotificationScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SendNotificationCubit, SendNotificationState>(builder: (context, state){
      return Scaffold();
    });
  }

}