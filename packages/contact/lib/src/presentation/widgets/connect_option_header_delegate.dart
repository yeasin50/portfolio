import 'package:contact/contact.dart';
import 'package:flutter/material.dart';

import 'package:core/core.dart' as core;
import 'package:effects/effects.dart' as eff;

///  single delegate for the title
class ConnectOptionHeaderDelegate extends SliverPersistentHeaderDelegate {
  const ConnectOptionHeaderDelegate({
    required this.title,
    this.scrolledRatio,
  });

  final String title;

  ///  amount of 0-1
  final double? scrolledRatio;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final theme = Theme.of(context).extension<ContactThemeExt>()!;

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints.tightFor(
          width: core.Spacing.maxWidth,
        ),
        child: Row(
          spacing: 24,
          children: [
            eff.HomeIcon(
              scrollProgress: scrolledRatio,
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
            Expanded(
              child: Text(
                title.replaceAll("\n", " "),
                style: theme.pageTitle,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  double get maxExtent => 100;

  @override
  double get minExtent => 100;

  @override
  bool shouldRebuild(covariant ConnectOptionHeaderDelegate oldDelegate) {
    return oldDelegate.scrolledRatio != scrolledRatio;
  }
}
