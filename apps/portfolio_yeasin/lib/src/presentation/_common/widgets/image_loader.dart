import 'package:core/core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:portfolio_yeasin/src/infrastructure/provider.dart';

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

    String? lowResImg, highResImage;
    if (context.appConfig.isGitProd) {
      //yea little logic here
      lowResImg = "${context.appConfig.imageDir!}low_res/$imgPath";
      highResImage = "${context.appConfig.imageDir!}high_res/$imgPath";
    }

    ///  handle low_res/high_res image load failure
    Widget buildImage(
      String imgPath,
      String? blurHash, {
      Widget? errorWidget,
    }) {
      return Image.network(
        imgPath,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) =>
            loadingProgress != null
                ? BlurHash(hash: blurHash ?? "LDDK_B%\$vfTI?dVFabaLqDNEHrtQ")
                : child,
        errorBuilder: (context, error, stackTrace) =>
            errorWidget ?? const ErrorImageWidget(),
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: AspectRatio(
        aspectRatio: 4 / 3,
        child: buildImage(
          (isThumbnail ? lowResImg : highResImage) ?? "",
          hash,
          errorWidget: buildImage(
            (isThumbnail ? highResImage : lowResImg) ?? "",
            hash,
          ),
        ),
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
