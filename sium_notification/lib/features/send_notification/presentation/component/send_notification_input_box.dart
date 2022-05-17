// coverage:ignore-file
import 'package:flutter/material.dart';

import '../../../../core/constants/text_styles.dart';

class SendNotificationInputBox extends StatelessWidget{
  final TextEditingController controller;
  final Function(String? value) onFieldSubmitted;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: SizedBox(
        height: 160,
        child: TextFormField(
          maxLines: null,
          expands: true,
          controller: controller,
          textInputAction: TextInputAction.done,
          onFieldSubmitted: onFieldSubmitted,
          textAlignVertical: TextAlignVertical.top,
          decoration: InputDecoration(
            labelText: "Note",
            labelStyle: sium16Regular,
            hintText: "Inserisci delle note",
            hintStyle: sium12Regular,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
          ),
        )
      ),
    );
  }

  const SendNotificationInputBox({
    required this.controller,
    required this.onFieldSubmitted,
  });
}