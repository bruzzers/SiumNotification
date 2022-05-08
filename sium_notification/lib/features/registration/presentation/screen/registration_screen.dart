// coverage:ignore-file
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sium_notification/core/component/sium_base_screen.dart';
import 'package:sium_notification/features/registration/presentation/cubit/registration_cubit.dart';

class RegistrationScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegistrationCubit, RegistrationState>(builder: (context, state){
      return SiumBaseScreen(body: Container(), title: "Registrazione", loading: false);
    });
  }

}