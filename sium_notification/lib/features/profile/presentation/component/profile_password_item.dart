// coverage:ignore-file
import 'package:flutter/material.dart';
import 'package:sium_notification/core/component/sium_button.dart';
import 'package:sium_notification/core/component/sium_text.dart';
import 'package:sium_notification/core/constants/text_styles.dart';

class ProfilePasswordItem extends StatelessWidget{
  final VoidCallback onTap;
  final bool isEditing;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SiumText("Password", style: sium18Bold,),
        if(isEditing)
          TextFormField(),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: SiumButton(color: Colors.blue, text: isEditing ? "Salva nuova password" : "Modifica password", onTap: onTap,),
        ),
        const Padding(padding: EdgeInsets.only(top: 12.0), child: Divider(color: Colors.grey, thickness: 1.0,))
      ],
    );
  }

  const ProfilePasswordItem({
    required this.onTap,
    required this.isEditing,
  });
}