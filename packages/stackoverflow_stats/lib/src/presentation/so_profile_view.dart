import 'dart:developer';

import 'package:collection/collection.dart';
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
            Row(
              spacing: 16,
              children: user.cardData.entries.mapIndexed(
                (i, e) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        e.value.toString(),
                        textAlign: TextAlign.center,
                        style: theme.titleStyle,
                      ),
                      Text(
                        e.key,
                        textAlign: TextAlign.center,
                        style: theme.labelStyle,
                      ),
                      const SizedBox(height: 8),
                      BadgeCounterView(
                        badge: SOBadge.empty.copyWith(
                          rank: switch (i) {
                            0 => "gold",
                            1 => "silver",
                            _ => "bronze"
                          },
                          awardCount: switch (i) {
                            0 => user.goldBadgeCount,
                            1 => user.silverBadgeCount,
                            _ => user.bronzeBadgeCount
                          },
                        ),
                      ),
                    ],
                  );
                },
              ).toList(),
            ),
          ],
        );
      },
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
