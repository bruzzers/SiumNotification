// coverage:ignore-file
import 'package:flutter/material.dart';

class SiumLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: null,
      child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: const Color(0x8BBDBDBD),
          child: const Align(alignment: Alignment.center,child: CircularProgressIndicator())),
    );
  }
}
