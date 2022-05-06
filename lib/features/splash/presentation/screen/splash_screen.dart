// coverage:ignore-file
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sium_notification/features/splash/presentation/cubit/splash_cubit.dart';

class SplashScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SplashCubit, SplashState>(builder: (context, state){
      return Scaffold(
        body: Align(
          alignment: Alignment.center,
          child: Image.asset("assets/images/ntt_logo.png")
        ),
      );
    });
  }

}