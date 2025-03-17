import 'dart:ui';

import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../../../app/app_theme.dart';
import '../../_common/utils/lerp_text.dart';
import '../../_common/widgets/navigation_buttons.dart';
import 'connects_simple_view.dart';

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
      clipBehavior: Clip.none,
      children: [
        Align(
          alignment: Alignment.lerp(
            const Alignment(0, -.5),
            Alignment.topLeft,
            t,
          )!,
          child: CompositedTransformTarget(
            link: layerLink,
            child: Padding(
              padding: EdgeInsets.only(top: 24, bottom: lerpDouble(48, 16, t)!),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    info.name,
                    style: nameTextStyle,
                    textAlign: TextAlign.center,
                  ),
                  DefaultSelectionStyle(
                    child: Text(
                      lerpText(info.title, info.shortTitle, t),
                      textAlign: TextAlign.left,
                      style: titleTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        // better will be fixed Height*t ig
        CompositedTransformFollower(
          link: layerLink,
          targetAnchor: Alignment.lerp(
            Alignment.bottomCenter,
            Alignment.bottomLeft,
            t,
          )!,
          followerAnchor: Alignment.lerp(
            Alignment.topCenter,
            Alignment.topLeft,
            t,
          )!,
          child: ConnectsSimpleView(animation: t),
        ),
        CompositedTransformFollower(
          link: layerLink,
          targetAnchor: Alignment.lerp(
            Alignment.bottomCenter,
            Alignment.bottomLeft,
            t,
          )!,
          followerAnchor: Alignment.lerp(
            Alignment.topCenter,
            Alignment.topLeft,
            t,
          )!,
          showWhenUnlinked: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              () {
                final text = lerpText(info.description, "", t * 2);
                return text.length < 5
                    ? const SizedBox.shrink()
                    : Padding(
                        padding: const EdgeInsets.symmetric(vertical: 100),
                        child: Text(
                          text,
                          textAlign: TextAlign.center,
                          style: textTheme.headlineLarge
                              ?.copyWith(color: textColor),
                        ),
                      );
              }(),
              Expanded(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24),
                    child: NavigationButtons(scrollT: t),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  double get maxExtent => maxHeight;

  @override
  double get minExtent => maxHeight;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
