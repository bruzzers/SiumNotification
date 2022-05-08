// coverage:ignore-file
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sium_notification/core/constants/text_styles.dart';

class SiumButton extends StatelessWidget{
  final Color color;
  final String text;
  final GestureTapCallback? onTap;
  final double? buttonWidth;
  final TextStyle? textStyle;

  const SiumButton({
    required this.color,
    required this.text,
    this.onTap,
    this.buttonWidth,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        type: MaterialType.transparency,
        child: Ink(
          width: buttonWidth,
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: onTap == null ? Colors.grey : color,
          ),
          child: InkWell(
            customBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            onTap: onTap,
            child: Center(
              child: Text(text,
                  style: textStyle ?? sium16RegularWhite),
            ),
          ),
        ),
      ),
    );
  }
}