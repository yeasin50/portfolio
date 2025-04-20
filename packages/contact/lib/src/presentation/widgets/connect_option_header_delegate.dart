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
        child: Stack(
          children: [
            Positioned.fill(
              left: 48,
              top: 8,
              bottom: 8,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      theme.expandIconColor.withAlpha(30),
                      theme.expandIconColor.withAlpha(0),
                    ],
                    stops: [0, .75],
                  ),
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 32.0 + 12),
                    child: Text(
                      title.replaceAll("\n", " "),
                      style: theme.pageTitle,
                    ),
                  ),
                ),
              ),
            ),
            eff.HomeIcon(
              scrollProgress: scrolledRatio,
              onTap: () {
                if (!Navigator.canPop(context)) return;
                Navigator.of(context).pop();
              },
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
