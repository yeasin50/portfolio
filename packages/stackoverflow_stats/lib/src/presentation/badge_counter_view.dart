import 'package:flutter/material.dart';
import 'package:stackoverflow_stats/src/domain/so_profile.dart';

class BadgeCounterView extends StatelessWidget {
  const BadgeCounterView({
    super.key,
    required this.user,
  });
  final SoProfile user;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: user.badges.entries
          .map(
            (e) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  Icon(Icons.gite_outlined),
                  const SizedBox(width: 8),
                  Text(e.value.toString()),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}
