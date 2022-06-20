// coverage:ignore-file
import 'package:flutter/material.dart';
import 'package:sium_notification/core/component/sium_text.dart';
import 'package:sium_notification/core/constants/text_styles.dart';

class RegistrationPasswordRuleItem extends StatelessWidget{
  final bool isValid;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: SiumText("- $text", style: isValid ? sium12RegularGreen : sium12RegularRed,),
    );
  }

  const RegistrationPasswordRuleItem({
    required this.isValid,
    required this.text,
  });
}