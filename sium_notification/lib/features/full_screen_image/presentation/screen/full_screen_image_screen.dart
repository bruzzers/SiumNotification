// coverage:ignore-file
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sium_notification/core/component/sium_base_screen.dart';
import 'package:sium_notification/features/full_screen_image/presentation/cubit/full_screen_image_cubit.dart';

class FullScreenImageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FullScreenImageCubit, FullScreenImageState>(
        builder: (context, state) {
      return SiumBaseScreen(
          body: Align(
            alignment: Alignment.center,
            child: InteractiveViewer(
              panEnabled: false,
              maxScale: 10,
              minScale: 1,
              child: Image.network(
                state.imageUrl ?? "",
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
          title: "Immagine",
          loading: false);
    });
  }
}
