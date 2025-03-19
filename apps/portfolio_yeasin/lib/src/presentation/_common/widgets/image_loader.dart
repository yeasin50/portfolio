import 'package:core/core.dart';
import 'package:flutter/material.dart';

class ImageLoader extends StatelessWidget {
  const ImageLoader({
    super.key,
    this.hash,
    required this.media,
  });

  final ProjectMedia? media;

  // for Blurhash
  final String? hash;

  @override
  Widget build(BuildContext context) {
    if (media == null) return const Placeholder();
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: AspectRatio(
        aspectRatio: 4 / 3,
        child: Image.network(
          media!.value,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => const Placeholder(),
        ),
      ),
    );
  }
}
