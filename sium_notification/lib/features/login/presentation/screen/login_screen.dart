// coverage:ignore-file
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sium_notification/core/component/sium_button.dart';
import 'package:sium_notification/core/component/sium_text.dart';
import 'package:sium_notification/core/constants/text_styles.dart';
import 'package:sium_notification/features/login/presentation/cubit/login_cubit.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Login"),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 18.0, right: 18.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: context.read<LoginCubit>().emailController,
                  decoration: InputDecoration(
                    labelText: "Email",
                    hintText: "Inserisci la tua mail",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: TextFormField(
                    controller: context.read<LoginCubit>().pswController,
                    decoration: InputDecoration(
                      labelText: "Password",
                      hintText: "Inserisci la tua password",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 18.0),
                  child: SiumText(
                    "Se non sei ancora iscritto, iscriviti ora",
                    style: sium16RegularUnderline,
                    onTap: () => context.read<LoginCubit>().goToRegistration(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 18.0),
                  child: Align(alignment: Alignment.center, child: SiumButton(text: "Accedi", onTap: () => context.read<LoginCubit>().signIn(), color: Colors.blue,),),
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
