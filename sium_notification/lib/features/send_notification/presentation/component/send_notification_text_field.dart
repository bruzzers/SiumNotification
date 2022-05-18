// coverage:ignore-file
import 'package:flutter/cupertino.dart';
import 'package:sium_notification/core/component/sium_text_field.dart';

class SendNotificationTextField extends StatelessWidget {
  final String title;
  final String hint;
  final TextEditingController controller;
  final bool isLast;
  final Function(String? value)? onFieldSubmitted;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: SiumTextField(
        controller: controller,
        label: title,
        hint: hint,
        isPassword: false,
        action: isLast ? TextInputAction.done : TextInputAction.next,
        onFieldSubmitted: onFieldSubmitted,
        isCapitalized: true,
      ),
    );
  }

  const SendNotificationTextField({
    required this.title,
    required this.hint,
    required this.controller,
    required this.isLast,
    this.onFieldSubmitted,
  });
}
