import 'package:core/core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';

///  Load simple image for web;
///
class ImageLoader extends StatelessWidget {
  const ImageLoader({
    super.key,
    this.hash,
    required this.media,
    this.isThumbnail = false,
  });

  final ProjectMedia? media;

  // for Blurhash
  final String? hash;

  /// determine   whether it should force to use small resolution  or high resolution  image
  /// default is true
  final bool isThumbnail;

  @override
  Widget build(BuildContext context) {
    if (media == null) return const Placeholder();
    String imgPath = media!.value;

    imgPath = imgPath.replaceAll("\\", "/");
    if (kDebugMode) {
      const prefix =
          "https://raw.githubusercontent.com/yeasin50/portfolio/refs/heads/dev/";
      imgPath = "$prefix$imgPath";
    }
    // https://raw.githubusercontent.com/yeasin50/portfolio/refs/heads/dev/server/database/images/high_res/diu_result.png

    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: AspectRatio(
        aspectRatio: 4 / 3,
        child: Image.network(imgPath,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) =>
                loadingProgress != null
                    ? BlurHash(
                        hash: hash ?? "LDDK_B%\$vfTI?dVFabaLqDNEHrtQ",
                      )
                    : child,
            errorBuilder: (context, error, stackTrace) =>
                const ErrorImageWidget()),
      ),
    );
  }
}

class ErrorImageWidget extends StatelessWidget {
  const ErrorImageWidget({
    super.key,
    this.hash,
  });
  final String? hash;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BlurHash(
          hash: hash ?? "LDDK_B%\$vfTI?dVFabaLqDNEHrtQ",
        ),
        const Center(
          child: Icon(
            Icons.error_outline_rounded,
            size: 32,
            color: Colors.red,
          ),
        )
      ],
    );
  }
}
