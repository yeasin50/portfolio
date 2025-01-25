import 'package:flutter/material.dart';

import '../../../app/app_theme.dart';
import '../../_common/utils/lerp_text.dart';

///  basic info will be used for the user
/// ```dart
/// const IntroInfo(
///     name: "Md. Yeasin Sheikh",
///     title: "Software Developer | Flutter specialist",
///     shortTitle: "SDE | Flutter",
///   );
///```
class IntroInfo {
  const IntroInfo({
    required this.name,
    required this.title,
    required this.shortTitle,
    required this.description,
  });

  final String name;
  final String title;
  final String shortTitle;
  final String description;
}

/// show user [name] and [intro];
/// but if user scroll down, only show the name in small case
/// and title completely disappear
///
/// [maxHeight] and [minHeight] are the constraints
///
class IntroPersistenceHeaderDelegate extends SliverPersistentHeaderDelegate {
  const IntroPersistenceHeaderDelegate({
    required this.info,
    required this.maxHeight,
    required this.minHeight,
  });

  final IntroInfo info;

  final double maxHeight;
  final double minHeight;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final textTheme = Theme.of(context).textTheme;
    final textColor = Theme.of(context).extension<AppTheme>()!.primaryText;

    final t = shrinkOffset / maxExtent;

    final nameTextStyle = TextStyleTween(
      begin: textTheme.displayLarge,
      end: textTheme.headlineLarge,
    ).lerp(t).copyWith(color: textColor);

    final titleTextStyle = TextStyleTween(
      begin: textTheme.headlineMedium,
      end: textTheme.titleLarge,
    ).lerp(t).copyWith(color: textColor);

    final LayerLink layerLink = LayerLink();

    return Stack(
      children: [
        Align(
          alignment: Alignment.lerp(
            const Alignment(0, -.35),
            Alignment.topLeft,
            t,
          )!,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                info.name,
                style: nameTextStyle,
                textAlign: TextAlign.left,
              ),
              CompositedTransformTarget(
                link: layerLink,
                child: DefaultSelectionStyle(
                  child: Text(
                    lerpText(info.title, info.shortTitle, t),
                    textAlign: TextAlign.left,
                    style: titleTextStyle,
                  ),
                ),
              ),
            ],
          ),
        ),
        CompositedTransformFollower(
          link: layerLink,
          targetAnchor: Alignment.bottomCenter,
          followerAnchor: Alignment.bottomCenter,
          offset: const Offset(0, 64),
          child: Text(
            lerpText(info.description, "", t * 2),
            textAlign: TextAlign.center,
            style: textTheme.headlineLarge?.copyWith(color: textColor),
          ),
        ),
      ],
    );
  }

  @override
  double get maxExtent => maxHeight;

  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
