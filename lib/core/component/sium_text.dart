// coverage:ignore-file
import 'package:flutter/material.dart';

class SiumText extends StatelessWidget{
  final String text;
  final TextStyle? style;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Text(
        text,
        style: style,
      ),
    );
  }

  const SiumText(this.text,{
    this.style,
    this.onTap,
  });
}