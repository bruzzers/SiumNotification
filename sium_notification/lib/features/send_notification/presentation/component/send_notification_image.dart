// coverage:ignore-file
import 'package:flutter/material.dart';
import 'package:sium_notification/core/component/sium_button.dart';

class SendNotificationImage extends StatelessWidget{
  final VoidCallback onButtonTap;
  final bool hasImage;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 18.0),
      child: SiumButton(color: Colors.orange, text: hasImage ? "Rimuovi immagine" : "Aggiungi un'immagine", onTap: onButtonTap,),
    );
  }

  const SendNotificationImage({
    required this.onButtonTap,
    required this.hasImage,
  });
}