// coverage:ignore-file
import 'package:flutter/material.dart';
import 'package:sium_notification/core/component/sium_button.dart';
import 'package:sium_notification/core/component/sium_text.dart';
import 'package:sium_notification/core/component/sium_text_field.dart';
import 'package:sium_notification/core/constants/text_styles.dart';

class ProfilePasswordItem extends StatelessWidget {
  final VoidCallback onTap;
  final VoidCallback onSaveTap;
  final bool isEditing;
  final TextEditingController controller;
  final bool? passwordObscured;
  final VoidCallback? onIconTap;
  final String? error;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!isEditing)
          const SiumText(
            "Password",
            style: sium18Bold,
          ),
        if (isEditing)
          SiumTextField(
            controller: controller,
            label: "Password",
            hint: "Inserisci la nuova password",
            isPassword: true,
            action: TextInputAction.done,
            passwordObscured: passwordObscured,
            onIconTap: onIconTap,
            error: error,
          ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: SiumButton(
            color: Colors.blue,
            text: isEditing ? "Salva nuova password" : "Modifica password",
            onTap: isEditing ? onSaveTap : onTap,
          ),
        ),
        const Padding(
            padding: EdgeInsets.only(top: 12.0),
            child: Divider(
              color: Colors.grey,
              thickness: 1.0,
            ))
      ],
    );
  }

  const ProfilePasswordItem({
    required this.onTap,
    required this.onSaveTap,
    required this.isEditing,
    required this.controller,
    this.passwordObscured,
    this.onIconTap,
    this.error,
  });
}
