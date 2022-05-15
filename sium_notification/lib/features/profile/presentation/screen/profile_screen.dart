// coverage:ignore-file
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sium_notification/core/component/sium_base_screen.dart';
import 'package:sium_notification/core/component/sium_button.dart';
import 'package:sium_notification/features/profile/presentation/component/profile_password_item.dart';
import 'package:sium_notification/features/profile/presentation/component/profile_text_item.dart';
import 'package:sium_notification/features/profile/presentation/cubit/profile_cubit.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(builder: (context, state) {
      return SiumBaseScreen(
          body: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 18.0, left: 18.0, right: 18.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ProfileTextItem(
                            title: "Username",
                            value: state.user?.displayName ?? "",
                            onTap: () => context
                                .read<ProfileCubit>()
                                .setEditUsername(
                                    !(state.isEditingUsername ?? false)),
                            isEditing: state.isEditingUsername ?? false,
                            onSaveTap: () =>
                                context.read<ProfileCubit>().updateUsername(),
                            textFieldHint: "Inserisci il nuovo username",
                            controller:
                                context.read<ProfileCubit>().usernameController,
                          ),
                          ProfileTextItem(
                            controller:
                                context.read<ProfileCubit>().emailController,
                            textFieldHint: "Inserisci la nuova email",
                            title: "Email",
                            value: state.user?.email ?? "",
                            onTap: () => context
                                .read<ProfileCubit>()
                                .setEditEmail(!(state.isEditingEmail ?? false)),
                            isEditing: state.isEditingEmail ?? false,
                            onSaveTap: () =>
                                context.read<ProfileCubit>().updateEmail(),
                            textFieldError: state.emailError,
                          ),
                          ProfilePasswordItem(
                            onTap: () => context
                                .read<ProfileCubit>()
                                .setEditPassword(
                                    !(state.isEditingPsw ?? false)),
                            onSaveTap: () => context.read<ProfileCubit>().updatePassword(),
                            isEditing: state.isEditingPsw ?? false,
                            controller:
                                context.read<ProfileCubit>().pswController,
                            onIconTap: () => context
                                .read<ProfileCubit>()
                                .setPasswordVisibility(),
                            passwordObscured: state.passwordObscured,
                            error: state.pswError,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      bottom: 18.0, left: 18.0, right: 18.0),
                  child: SiumButton(
                    color: Colors.red,
                    text: "Logout",
                    onTap: () => context.read<ProfileCubit>().logout(),
                  ),
                )
              ],
            ),
          ),
          title: "Profilo",
          loading: state.isLoading);
    });
  }
}
