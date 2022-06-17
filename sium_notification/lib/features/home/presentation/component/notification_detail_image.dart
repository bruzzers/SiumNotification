// coverage:ignore-file
import 'package:flutter/material.dart';

class NotificationDetailImage extends StatelessWidget{
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: Image.network(imageUrl ?? ""),
    );
  }

  const NotificationDetailImage({
    this.imageUrl,
  });
}