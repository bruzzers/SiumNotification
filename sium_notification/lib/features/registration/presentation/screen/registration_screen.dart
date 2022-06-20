// coverage:ignore-file
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sium_notification/core/component/sium_base_screen.dart';
import 'package:sium_notification/core/component/sium_button.dart';
import 'package:sium_notification/core/component/sium_text.dart';
import 'package:sium_notification/core/component/sium_text_field.dart';
import 'package:sium_notification/core/constants/text_styles.dart';
import 'package:sium_notification/features/registration/presentation/component/registration_password_rule_item.dart';
import 'package:sium_notification/features/registration/presentation/cubit/registration_cubit.dart';

class RegistrationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegistrationCubit, RegistrationState>(
        builder: (context, state) {
      return SiumBaseScreen(
          body: Padding(
            padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
            child: SafeArea(
              child: Align(
                alignment: Alignment.center,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 18.0, right: 18.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SiumTextField(
                          controller:
                              context.read<RegistrationCubit>().emailController,
                          label: "Email*",
                          hint: "Inserisci la tua mail",
                          isPassword: false,
                          error: state.errors?["email"],
                          action: TextInputAction.next,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: SiumTextField(
                            action: TextInputAction.next,
                            controller:
                                context.read<RegistrationCubit>().usernameController,
                            label: "Username",
                            hint: "Inserisci il tuo username (Facoltativo)",
                            isPassword: false,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: SiumTextField(
                            controller:
                                context.read<RegistrationCubit>().pswController,
                            label: "Password*",
                            hint: "Inserisci la tua password",
                            isPassword: true,
                            error: state.errors?["psw"],
                            passwordObscured: state.passwordObscured,
                            action: TextInputAction.done,
                            onIconTap: () =>
                                context.read<RegistrationCubit>().setVisibility(),
                            onFieldSubmitted: (string) => context
                                .read<RegistrationCubit>()
                                .checkValuesAndRegister(),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 12.0),
                          child: SiumText("La password deve contenere:", style: sium16Regular,),
                        ),
                        RegistrationPasswordRuleItem(isValid: state.pswHas8Char ?? false, text: "Almeno 8 caratteri"),
                        RegistrationPasswordRuleItem(isValid: state.pswHasUpperCase ?? false, text: "1 Carattere maiuscolo (A-Z)"),
                        RegistrationPasswordRuleItem(isValid: state.pswHasLowerCase ?? false, text: "1 Carattere minuscolo (a-z)"),
                        RegistrationPasswordRuleItem(isValid: state.pswHasNumber ?? false, text: "1 numero (0-9)"),
                        RegistrationPasswordRuleItem(isValid: state.pswHasSpecial ?? false, text: "1 Carattere speciale (!?\$%&)"),
                        Padding(
                          padding: const EdgeInsets.only(top: 36.0),
                          child: SiumButton(
                            color: Colors.blue,
                            text: "Registrati",
                            onTap: state.ctaIsEnabled == true
                                ? () =>
                                    context.read<RegistrationCubit>().registerUser()
                                : null,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          title: "Registrazione",
          loading: state.isLoading);
    });
  }
}
