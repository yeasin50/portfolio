import 'package:core/core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';

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
    String imgPath = media!.value;

    if (kDebugMode) {
      imgPath = imgPath.replaceAll("\\", "/");
      const prefix =
          "https://raw.githubusercontent.com/yeasin50/portfolio/refs/heads/dev/";
      imgPath = "$prefix$imgPath";
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: AspectRatio(
        aspectRatio: 4 / 3,
        child: Image.network(
          imgPath,
          fit: BoxFit.cover,
          loadingBuilder: (context, child, loadingProgress) =>
              loadingProgress != null
                  ? BlurHash(
                      hash: hash ?? "LDDK_B%\$vfTI?dVFabaLqDNEHrtQ",
                    )
                  : child,
          errorBuilder: (context, error, stackTrace) => const Placeholder(),
        ),
      ),
    );
  }
}
