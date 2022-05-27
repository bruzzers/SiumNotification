// coverage:ignore-file
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sium_notification/core/component/sium_base_screen.dart';
import 'package:sium_notification/core/component/sium_button.dart';
import 'package:sium_notification/core/component/sium_text.dart';
import 'package:sium_notification/core/component/sium_text_field.dart';
import 'package:sium_notification/core/constants/text_styles.dart';
import 'package:sium_notification/features/reset_password/presentation/cubit/reset_password_cubit.dart';

class ResetPasswordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ResetPasswordCubit, ResetPasswordState>(
        builder: (context, state) {
      return SiumBaseScreen(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 18.0, right: 18.0, top: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SiumText(
                      "Qua puoi effettuare il reset della password",
                      style: sium18Bold,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 12.0),
                      child: SiumText(
                        "Inserisci la tua email e una volta premuto sul pulsante controlla la tua casella email",
                        style: sium16Regular,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 24.0),
                      child: SiumTextField(
                        controller:
                            context.read<ResetPasswordCubit>().emailController,
                        label: "Email",
                        hint: "Inserisci la tua mail",
                        isPassword: false,
                        error: state.emailError,
                        action: TextInputAction.done,
                        onFieldSubmitted: (_) => context.read<ResetPasswordCubit>().resetPassword(),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 18.0),
                      child: SiumButton(
                        color: Colors.blue,
                        text: "Reset",
                        onTap: state.ctaEnabled &&
                                context
                                    .read<ResetPasswordCubit>()
                                    .emailController
                                    .text
                                    .isNotEmpty
                            ? () => context
                                .read<ResetPasswordCubit>()
                                .resetPassword()
                            : null,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          title: "Reset Password",
          loading: state.isLoading);
    });
  }
}
