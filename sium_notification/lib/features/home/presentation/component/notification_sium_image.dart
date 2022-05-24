// coverage:ignore-file
import 'package:flutter/material.dart';

class NotificationSiumImage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      height: 70,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
            image: Image.asset(
                'assets/images/sium_vote.png')
                .image,
            fit: BoxFit.fill),
      ),
    );
  }

}