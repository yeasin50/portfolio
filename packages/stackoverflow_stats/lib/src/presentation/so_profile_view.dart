import 'dart:developer';

import 'package:effects/effects.dart' as eff;
import 'package:flutter/material.dart';
import 'package:stackoverflow_stats/stackoverflow_stats.dart';

///  show user [userId] profile
///! https://stackoverflow.com/users/10157127/
///  here `10157127` is the userId
///
class SoProfileView extends StatefulWidget {
  const SoProfileView({
    super.key,
    required this.userId,
    this.description,
  });

  final int userId;
  final String? description;

  @override
  State<SoProfileView> createState() => _SoProfileViewState();
}

class _SoProfileViewState extends State<SoProfileView> {
  final SOUserRepo repo = SOUserRepo();

  late final Future<SoProfile?> future = repo.getUserProfile(widget.userId);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<StackOverflowTheme>()!;

    return FutureBuilder<SoProfile?>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const _SoLoadingView();
        }
        final user = snapshot.data;

        if (user == null || snapshot.hasError) {
          log("failed to get user ${snapshot.error}");
          return const Text(
            "Failed to get the user",
          );
        }

        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: 16,
          children: [
            if ((widget.description ?? "").isNotEmpty)
              Text(
                widget.description!,
                style: theme.labelStyle,
              ),
            _UserStats(profile: snapshot.data!)
          ],
        );
      },
    );
  }
}

class _UserStats extends StatelessWidget {
  const _UserStats({
    super.key,
    required this.profile,
  });
  final SoProfile profile;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<StackOverflowTheme>()!;

    List<Widget> children = [];

    final List<SOBadge> badges = [
      SOBadge.empty.copyWith(
        rank: "gold",
        awardCount: profile.goldBadgeCount,
      ),
      SOBadge.empty.copyWith(
        rank: "sliver",
        awardCount: profile.silverBadgeCount,
      ),
      SOBadge.empty.copyWith(
        rank: "bronze",
        awardCount: profile.bronzeBadgeCount,
      ),
    ];

    if (profile.reached != null) {
      children.add(
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              profile.reached!,
              style: theme.titleStyle.copyWith(
                fontSize: theme.titleStyle.fontSize! * 2,
              ),
            ),
            Text(
              "people reached",
              style: theme.titleStyle.copyWith(
                fontWeight: FontWeight.normal,
              ),
            ),
            const SizedBox(height: 24),
            _BadgeView(badges: badges),
          ],
        ),
      );
    }

    children.add(
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            profile.reputation.toString(),
            style: theme.titleStyle.copyWith(
              fontSize: theme.titleStyle.fontSize! * 1.5,
            ),
          ),
          Text(
            "Reputation",
            style: theme.titleStyle.copyWith(
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
    );

    children.add(
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            profile.totalAnswer.toString(),
            style: theme.titleStyle.copyWith(
              fontSize: theme.titleStyle.fontSize! * 1.5,
            ),
          ),
          Text(
            "answers",
            style: theme.titleStyle.copyWith(
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
    );
    children.add(
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            profile.totalQuestion.toString(),
            style: theme.titleStyle.copyWith(
              fontSize: theme.titleStyle.fontSize!,
            ),
          ),
          Text(
            "questions",
            style: theme.titleStyle.copyWith(
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
    );

    return eff.GoldenSpiralRecursive(
      size: const Size(300, 300),
      children: children
          .map(
            (e) => eff.SphereView(
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: e,
              ),
            ),
          )
          .toList(),
    );
  }
}

class _BadgeView extends StatelessWidget {
  const _BadgeView({required this.badges});

  final List<SOBadge> badges;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      spacing: 16,
      children: [
        for (final b in badges) BadgeCounterView(badge: b),
      ],
    );
  }
}

class _SoLoadingView extends StatelessWidget {
  const _SoLoadingView();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
