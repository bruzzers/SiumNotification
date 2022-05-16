// coverage:ignore-file
import 'package:flutter/material.dart';
import 'package:sium_notification/core/component/sium_button.dart';

class ProfileImageItem extends StatelessWidget{
  final String? imageUrl;
  final VoidCallback onGalleryTap;
  final VoidCallback onCameraTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 150,
          height: 150,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
                image: imageUrl != null && imageUrl?.isNotEmpty == true ? Image.network(imageUrl ?? "").image : Image.asset(
                    'assets/images/propic_placeholder.png')
                    .image,
                fit: BoxFit.fill),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 12.0),
          child: SiumButton(color: Colors.blue, text: "Seleziona immagine di profilo", onTap: onGalleryTap,),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 12.0),
          child: SiumButton(color: Colors.blue, text: "Scatta immagine di profilo", onTap: onCameraTap,),
        )
      ],
    );
  }

  const ProfileImageItem({
    this.imageUrl,
    required this.onGalleryTap,
    required this.onCameraTap,
  });
}