import 'package:flutter/material.dart';

import '../../../app/app_theme.dart';

/// show user [name] and [intro];
/// but if user scroll down, only show the name in small case
/// and title completely disappear
///
/// [maxHeight] and [minHeight] are the constraints
///
class IntroPersistenceHeaderDelegate extends SliverPersistentHeaderDelegate {
  const IntroPersistenceHeaderDelegate({
    required this.name,
    required this.intro,
    required this.maxHeight,
    required this.minHeight,
  });

  final String name;

  final String intro;

  final double maxHeight;
  final double minHeight;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final textTheme = Theme.of(context).textTheme;
    final textColor = Theme.of(context).extension<AppTheme>()!.primaryText;

    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              name,
              style: textTheme.displayLarge?.copyWith(
                color: textColor,
              ),
            ),
            Text(
              intro,
              style: textTheme.headlineMedium?.copyWith(
                color: textColor,
              ),
            ),
          ],
        )
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
