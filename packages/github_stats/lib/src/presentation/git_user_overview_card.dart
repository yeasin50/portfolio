import 'package:flutter/material.dart';

import '../domain/github_user.dart';

class GitUserOverviewCard extends StatelessWidget {
  const GitUserOverviewCard({
    super.key,
    required this.user,
  });

  final GithubUser user;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Image.network(
              user.avatar,
              fit: BoxFit.cover,
              width: 64,
              height: 64,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(user.name),
                  Text(
                    "@${user.id}",
                    style: textTheme.titleMedium,
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        _StatsRow(user),
      ],
    );
  }
}

class _StatsRow extends StatelessWidget {
  const _StatsRow(this.user);

  final GithubUser user;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: {
        if (user.totalRepo > 0) MapEntry("Repos", user.totalRepo),
        if (user.totalGist > 0) MapEntry("Gists", user.totalGist),
        if (user.followers > 0) MapEntry("Followers", user.followers),
      }
          .map(
            (e) => Column(
              children: [
                Text(
                  e.value.toString(),
                  style: textTheme.titleMedium
                      ?.copyWith(fontWeight: FontWeight.w600),
                ),
                Text(
                  e.key,
                  style: textTheme.bodyMedium?.copyWith(),
                ),
              ],
            ),
          )
          .toList(),
    );
  }
}
