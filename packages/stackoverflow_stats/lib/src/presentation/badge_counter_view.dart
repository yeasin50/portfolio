import 'package:flutter/material.dart';
import 'package:stackoverflow_stats/stackoverflow_stats.dart';

class BadgeCounterView extends StatelessWidget {
  const BadgeCounterView({
    super.key,
    required this.user,
  });
  final SoProfile user;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<StackOverflowTheme>()!;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: user.badges.entries
          .map(
            (e) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  Icon(
                    Icons.gite_outlined,
                    color: switch (e.key) {
                      "gold" => theme.gold,
                      "silver" => theme.silver,
                      "bronze" => theme.bronze,
                      _ => theme.labelStyle.color
                    },
                  ),
                  const SizedBox(width: 8),
                  Text(
                    e.value.toString(),
                    style: theme.badgeTextStyle,
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}
