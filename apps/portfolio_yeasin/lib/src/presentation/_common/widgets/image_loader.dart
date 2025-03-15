import 'dart:io' if (dart.library.html) 'dummy.dart' as io;

import 'package:core/core.dart';
import 'package:flutter/foundation.dart';
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

  String get localPath {
    final fileName = media?.value.split('/').last;
    return '../../server/database/images/$fileName';
  }

  @override
  Widget build(BuildContext context) {
    if (media == null) return const Placeholder();
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: AspectRatio(
        aspectRatio: 4 / 3,
        child: kDebugMode
            ? Image.file(
                io.File(localPath),
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    const Placeholder(),
              )
            : Image.network(
                media!.value,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    const Placeholder(),
              ),
      ),
    );
  }
}
