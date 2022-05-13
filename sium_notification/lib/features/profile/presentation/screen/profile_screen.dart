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
                          ),
                          ProfileTextItem(
                            title: "Email",
                            value: state.user?.email ?? "",
                            onTap: () => context
                                .read<ProfileCubit>()
                                .setEditEmail(
                                    !(state.isEditingEmail ?? false)),
                            isEditing: state.isEditingEmail ?? false,
                          ),
                          ProfilePasswordItem(
                            onTap: () => context
                                .read<ProfileCubit>()
                                .setEditPassword(
                                    !(state.isEditingPsw ?? false)),
                            isEditing: state.isEditingPsw ?? false,
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
                    onTap: () {},
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
