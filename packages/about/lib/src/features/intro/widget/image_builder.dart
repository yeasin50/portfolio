import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';

class NetworkImageBuilder extends StatelessWidget {
  const NetworkImageBuilder({
    super.key,
    required this.imageUrl,
    this.hash,
  });

  final String imageUrl;

  ///use hash for loading image from cache [flutter_blurhash]
  final String? hash;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: 300,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: AspectRatio(
          aspectRatio: 1,
          child: hash == null
              ? Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                )
              : BlurHash(
                  hash: hash!,
                  image: imageUrl,
                ),
        ),
      ),
    );
  }
}
