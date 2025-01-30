import 'package:flutter/material.dart';
import 'package:portfolio_yeasin/src/presentation/home/widgets/connect_view.dart';

import '../../../app/app_theme.dart';
import '../../_common/utils/lerp_text.dart';
import '../../_common/widgets/navigation_buttons.dart';

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
            const Alignment(0, -.5),
            Alignment.topLeft,
            t,
          )!,
          child: CompositedTransformTarget(
            link: layerLink,
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
                //TODO:  left transition
                CompositedTransformFollower(
                  link: layerLink,
                  targetAnchor: Alignment.bottomLeft,
                  followerAnchor: Alignment.bottomLeft,
                  offset: const Offset(0, 24),
                  child: ConstrainedBox(
                    constraints: BoxConstraints.loose(const Size(56, 56)),
                    child: const ConnectView(),
                  ),
                ),
              ],
            ),
          ),
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
                        padding: const EdgeInsets.symmetric(vertical: 64),
                        child: Text(
                          text,
                          textAlign: TextAlign.center,
                          style: textTheme.headlineLarge
                              ?.copyWith(color: textColor),
                        ),
                      );
              }(),
              Expanded(
                child: Center(
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
