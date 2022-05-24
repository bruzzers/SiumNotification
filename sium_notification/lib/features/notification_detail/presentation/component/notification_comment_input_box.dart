// coverage:ignore-file
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/text_styles.dart';

class NotificationCommentInputBox extends StatelessWidget{
  final TextEditingController controller;
  final Function(String? comment) onFieldSubmitted;

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
            textCapitalization: TextCapitalization.sentences,
            autocorrect: false,
            decoration: InputDecoration(
              labelText: "Commento",
              labelStyle: sium16Regular,
              hintText: "Inserisci un commento",
              hintStyle: sium12Regular,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
            ),
          )
      ),
    );
  }

  const NotificationCommentInputBox({
    required this.controller,
    required this.onFieldSubmitted,
  });
}