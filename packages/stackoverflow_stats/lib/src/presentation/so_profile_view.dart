import 'dart:developer';

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
  });

  final int userId;

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

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Wrap(
                runSpacing: 16,
                spacing: 16,
                alignment: WrapAlignment.center,
                children: user.cardData.entries.map(
                  (e) {
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
                      ],
                    );
                  },
                ).toList(),
              ),
              const SizedBox(height: 8),
              BadgeCounterView(user: user),
            ],
          ),
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
