import 'package:flutter/material.dart';
import 'package:stackoverflow_stats/stackoverflow_stats.dart';

class BadgeCounterView extends StatelessWidget {
  const BadgeCounterView({
    super.key,
    required this.badge,
  });
  final SOBadge badge;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<StackOverflowTheme>()!;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.emoji_events,
          color: switch (badge.rank) {
            "gold" => theme.gold,
            "silver" => theme.silver,
            "bronze" => theme.bronze,
            _ => theme.labelStyle.color
          },
        ),
        const SizedBox(width: 8),
        Text(
          badge.awardCount.toString(),
          style: theme.labelStyle,
        ),
      ],
    );
  }
}
