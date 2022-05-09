// coverage:ignore-file
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sium_notification/core/component/sium_base_screen.dart';
import 'package:sium_notification/core/component/sium_button.dart';
import 'package:sium_notification/core/constants/text_styles.dart';
import 'package:sium_notification/features/registration/presentation/cubit/registration_cubit.dart';

class RegistrationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegistrationCubit, RegistrationState>(
        builder: (context, state) {
      return SiumBaseScreen(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(left: 18.0, right: 18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    controller:
                        context.read<RegistrationCubit>().emailController,
                    decoration: InputDecoration(
                      labelText: "Email",
                      labelStyle: sium16Regular,
                      hintText: "Inserisci la tua mail",
                      hintStyle: sium16Regular,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: TextFormField(
                      controller:
                          context.read<RegistrationCubit>().pswController,
                      decoration: InputDecoration(
                        labelText: "Password",
                        labelStyle: sium16Regular,
                        hintText: "Inserisci la tua password",
                        hintStyle: sium16Regular,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 36.0),
                    child: SiumButton(
                      color: Colors.blue,
                      text: "Registrati",
                      onTap: () =>
                          context.read<RegistrationCubit>().registerUser(),
                    ),
                  )
                ],
              ),
            ),
          ),
          title: "Registrazione",
          loading: state.isLoading);
    });
  }
}
