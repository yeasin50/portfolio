import 'package:flutter/material.dart';
import 'package:stackoverflow_stats/stackoverflow_stats.dart';

class BadgeLabelChip extends StatelessWidget {
  const BadgeLabelChip({
    super.key,
    required this.badge,
  });

  final SOBadge badge;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<StackOverflowTheme>()!;

    return Text(
      badge.name,
      style: theme.badgeTextStyle,
    );
  }
}
