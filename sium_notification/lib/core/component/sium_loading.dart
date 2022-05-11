// coverage:ignore-file
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SiumLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: null,
      child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: const Color(0x8BBDBDBD),
          child: Align(alignment: Alignment.center,child: Lottie.asset("assets/lottie_animations/loader.json"))),
    );
  }
}
