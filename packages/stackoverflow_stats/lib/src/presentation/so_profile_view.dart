import 'dart:developer';

import 'package:effects/effects.dart' as eff;

import 'package:flutter/material.dart';
import 'package:stackoverflow_stats/stackoverflow_stats.dart';

import 'so_stats_view.dart';

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
            SOUserStats(profile: snapshot.data!)
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
    final width = MediaQuery.sizeOf(context).width;
    double scale = 1;
    if (width < 300 * 2) {
      scale = width / 600;
    }

    return eff.GoldenSpiralRecursive(
      size: const Size(300, 300) * scale,
      children: List.generate(
        4,
        (i) => eff.SphereView(
          disableHover: true,
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: CircularProgressIndicator(
              color: Colors.primaries.reversed.elementAt(i).withAlpha(100),
            ),
          ),
        ),
      ).toList(),
    );
  }
}
