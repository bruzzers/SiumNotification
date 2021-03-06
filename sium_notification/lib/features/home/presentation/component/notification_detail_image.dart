// coverage:ignore-file
import 'dart:ffi';

import 'package:flutter/material.dart';

class NotificationDetailImage extends StatelessWidget {
  final String? imageUrl;
  final VoidCallback? onImageTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: InkWell(
        onTap: onImageTap,
        child: SizedBox(
          height: 200,
          width: 200,
          child: Image.network(
            imageUrl ?? "",
            loadingBuilder: (BuildContext context, Widget child,
                ImageChunkEvent? loadingProgress) {
              if (loadingProgress == null) return child;
              return Center(
                child: CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                      : null,
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  const NotificationDetailImage({
    this.imageUrl,
    this.onImageTap,
  });
}
