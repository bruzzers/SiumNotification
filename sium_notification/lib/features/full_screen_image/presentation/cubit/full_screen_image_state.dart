part of 'full_screen_image_cubit.dart';

class FullScreenImageState extends BaseState{
  final String? imageUrl;

  @override
  List<Object?> get props => [imageUrl];

  FullScreenImageState({
    this.imageUrl,
  });

  FullScreenImageState copyWith({
    String? imageUrl,
  }) {
    return FullScreenImageState(
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}
