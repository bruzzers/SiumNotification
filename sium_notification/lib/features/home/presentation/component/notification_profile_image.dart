// coverage:ignore-file
import 'package:flutter/material.dart';

class NotificationProfileImage extends StatelessWidget{
  final String? imageUrl;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
            image: imageUrl != null && imageUrl?.isNotEmpty == true ? Image.network(imageUrl ?? "").image : Image.asset(
                'assets/images/propic_placeholder.png')
                .image,
            fit: BoxFit.fill),
      ),
    );
  }

  const NotificationProfileImage({
    this.imageUrl,
  });

}