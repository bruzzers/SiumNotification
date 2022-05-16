// coverage:ignore-file
import 'package:flutter/material.dart';
import 'package:sium_notification/core/component/sium_button.dart';
import 'package:sium_notification/core/component/sium_text.dart';
import 'package:sium_notification/core/component/sium_text_field.dart';
import 'package:sium_notification/core/constants/text_styles.dart';

class ProfileTextItem extends StatelessWidget {
  final String title;
  final String value;
  final VoidCallback onTap;
  final bool isEditing;
  final VoidCallback onSaveTap;
  final TextEditingController controller;
  final String textFieldHint;
  final String? textFieldError;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 12.0),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (!isEditing)
                      SiumText(
                        title,
                        style: sium18Bold,
                      ),
                    if (isEditing) ...[
                      SiumTextField(
                        action: TextInputAction.done,
                        controller: controller,
                        label: title,
                        hint: textFieldHint,
                        isPassword: false,
                        error: textFieldError,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 12.0,
                        ),
                        child: SiumButton(
                          color: Colors.blue,
                          text: "Salva",
                          onTap: onSaveTap,
                        ),
                      )
                    ] else
                      Padding(
                        padding: const EdgeInsets.only(top: 12.0),
                        child: SiumText(
                          value,
                          style: sium16Regular,
                        ),
                      ),
                  ],
                ),
              ),
              IconButton(
                  onPressed: onTap,
                  icon: Icon(isEditing == true ? Icons.edit_off : Icons.edit))
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(top: 12.0),
          child: Divider(
            color: Colors.grey,
            thickness: 1.0,
          ),
        ),
      ],
    );
  }

  const ProfileTextItem({
    required this.title,
    required this.value,
    required this.onTap,
    required this.isEditing,
    required this.onSaveTap,
    required this.controller,
    required this.textFieldHint,
    this.textFieldError,
  });
}
