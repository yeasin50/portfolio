import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import 'dart:math' as math;

import '../domain/badge.dart';
import '../infrastructure/user_repo.dart';

///  show user [userId]  badges
class BadgesCard extends StatefulWidget {
  const BadgesCard({
    super.key,
    required this.userId,
    this.maxPreview = const (null, 10, 20),
  });

  final int userId;

  /// if null then it will render all
  final (int? gold, int? silver, int? bronze) maxPreview;

  @override
  State<BadgesCard> createState() => _BadgesCardState();
}

class _BadgesCardState extends State<BadgesCard> {
  final SOUserRepo repo = SOUserRepo();

  late final Future<List<SOBadge>> future = repo.getBadges(widget.userId);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<SOBadge>>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const _BadgeLoadingView();
        }
        if (snapshot.hasError) {
          log(snapshot.error.toString());
          return const Text("Failed to load");
        }

        final items = groupBy(snapshot.data!, (p0) => p0.rank);

        List<SOBadge> goldItems = items["gold"] ?? [];
        if (widget.maxPreview.$1 != null) {
          goldItems = goldItems.sublist(
            0,
            math.min(goldItems.length, widget.maxPreview.$1!),
          );
        }

        List<SOBadge> silverItems = items["silver"] ?? [];
        if (widget.maxPreview.$2 != null) {
          silverItems = silverItems.sublist(
            0,
            math.min(silverItems.length, widget.maxPreview.$2!),
          );
        }

        List<SOBadge> bronzeItems = items["bronze"] ?? [];
        if (widget.maxPreview.$3 != null) {
          bronzeItems = bronzeItems.sublist(
            0,
            math.min(bronzeItems.length, widget.maxPreview.$3!),
          );
        }

        return Column(
          children: [goldItems, silverItems, bronzeItems]
              .map(
                (e) => ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: 250,
                    minWidth: 100,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: e.map((e) => Text(e.name)).toList(),
                    ),
                  ),
                ),
              )
              .toList(),
        );
      },
    );
  }
}

class _BadgeLoadingView extends StatelessWidget {
  const _BadgeLoadingView();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
