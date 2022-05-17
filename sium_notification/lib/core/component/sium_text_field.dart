// coverage:ignore-file
import 'package:flutter/material.dart';

import '../constants/text_styles.dart';

class SiumTextField extends StatelessWidget{
  final TextEditingController controller;
  final String label;
  final String hint;
  final String? error;
  final bool isPassword;
  final bool? passwordObscured;
  final VoidCallback? onIconTap;
  final TextInputAction action;
  final Function(String value)? onFieldSubmitted;
  final bool? isCapitalized;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      textInputAction: action,
      onFieldSubmitted: onFieldSubmitted,
      textCapitalization: isCapitalized == true? TextCapitalization.sentences : TextCapitalization.none,
      autocorrect: false,
      obscureText: isPassword ? passwordObscured ?? true : false,
      decoration: InputDecoration(
        labelText: label,
        errorText: error,
        errorStyle: sium12RegularRed,
        labelStyle: sium16Regular,
        hintText: hint,
        suffixIcon: isPassword ? IconButton(
          icon: Icon(
              passwordObscured != false ? Icons.visibility : Icons.visibility_off
          ),
          onPressed: onIconTap,
        ) : null,
        hintStyle: sium12Regular,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
      ),
    );
  }

  const SiumTextField({
    required this.controller,
    required this.label,
    required this.hint,
    this.error,
    required this.isPassword,
    this.passwordObscured,
    this.onIconTap,
    required this.action,
    this.onFieldSubmitted,
    this.isCapitalized,
  });
}