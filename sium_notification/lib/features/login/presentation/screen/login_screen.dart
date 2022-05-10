// coverage:ignore-file
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sium_notification/core/component/sium_base_screen.dart';
import 'package:sium_notification/core/component/sium_button.dart';
import 'package:sium_notification/core/component/sium_text.dart';
import 'package:sium_notification/core/constants/text_styles.dart';
import 'package:sium_notification/features/login/presentation/cubit/login_cubit.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(builder: (context, state) {
      return SiumBaseScreen(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(left: 18.0, right: 18.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: context.read<LoginCubit>().emailController,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      labelText: "Email",
                      labelStyle: sium16Regular,
                      hintText: "Inserisci la tua mail",
                      hintStyle: sium12Regular,
                      errorText: state.errors?["email"],
                      errorStyle: sium12RegularRed,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: TextFormField(
                      controller: context.read<LoginCubit>().pswController,
                      obscureText: state.passwordObscured ?? true,
                      textInputAction: TextInputAction.done,
                      onFieldSubmitted: (string) => context.read<LoginCubit>().checkValuesAndLogin(),
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: Icon(state.passwordObscured != false
                              ? Icons.visibility
                              : Icons.visibility_off),
                          onPressed: () =>
                              context.read<LoginCubit>().setVisibility(),
                        ),
                        labelText: "Password",
                        labelStyle: sium16Regular,
                        hintText: "Inserisci la tua password",
                        hintStyle: sium12Regular,
                        errorText: state.errors?["psw"],
                        errorStyle: sium12RegularRed,
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
                      onTap: () =>
                          context.read<LoginCubit>().goToRegistration(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 18.0),
                    child: Align(
                      alignment: Alignment.center,
                      child: SiumButton(
                        text: "Accedi",
                        onTap: state.ctaIsEnabled == true ? () => context.read<LoginCubit>().signIn() : null,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  /*Padding(
                  padding: const EdgeInsets.only(top: 18.0),
                  child: Align(alignment: Alignment.center, child: SiumButton(text: "Accedi con Google", onTap: () => context.read<LoginCubit>().signInWithGoogle(), color: Colors.blue,),),
                )*/
                ],
              ),
            ),
          ),
          title: "Login",
          loading: state.isLoading);
    });
  }
}
