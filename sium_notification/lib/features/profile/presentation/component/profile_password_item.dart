// coverage:ignore-file
import 'package:flutter/material.dart';
import 'package:sium_notification/core/component/sium_button.dart';
import 'package:sium_notification/core/component/sium_text.dart';
import 'package:sium_notification/core/constants/text_styles.dart';

class ProfilePasswordItem extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        SiumText("Password", style: sium18Bold,),
        Padding(
          padding: EdgeInsets.only(top: 8.0),
          child: SiumButton(color: Colors.blue, text: "Modifica password"),
        ),
        Padding(padding: EdgeInsets.only(top: 12.0), child: Divider(color: Colors.grey, thickness: 1.0,))
      ],
    );
  }

}