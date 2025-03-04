import 'package:flutter/material.dart';
import 'package:portfolio_yeasin/src/infrastructure/connect_repo.dart';
import 'package:effects/effects.dart' as eff;

import '../../../app/app.dart';

class PreferenceBuilder extends StatelessWidget {
  const PreferenceBuilder({
    super.key,
    required this.item,
  });

  final PreferenceData item;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final textColor = Theme.of(context).extension<AppTheme>()!.primaryText;

    return Column(
      children: [
        eff.AnimatedExpansionTile(
          title: Text(
            item.title, //or titleLarge
            style: textTheme.headlineLarge?.copyWith(
              color: textColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          // initialExpanded: true,
          //TODO:: FIND A GOOD PATTERN
          lowerBound: item.items.isEmpty ? .80 : .23,
          //     item.items.isEmpty && item.description.length < 300 ? 1 : .2,
          children: [
            if (item.description.isNotEmpty)
              Flexible(
                child: Text(
                  item.description,
                  style: item.items.entries.isEmpty
                      ? textTheme.bodyLarge?.copyWith(color: textColor)
                      : textTheme.bodyLarge?.copyWith(color: textColor),
                ),
              ),
            for (final li in item.items.entries)
              Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: PreferenceItemBuilder(data: li, type: item.type),
              ),
          ],
        ),
      ],
    );
  }
}

class PreferenceItemBuilder extends StatelessWidget {
  ///
  const PreferenceItemBuilder({
    super.key,
    required this.data,
    required this.type,
  });

  final MapEntry<String, List<String>> data;
  final eff.BulletType? type;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final textColor = Theme.of(context).extension<AppTheme>()!.primaryText;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (data.key.isNotEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Text(
              data.key,
              style: textTheme.headlineSmall?.copyWith(
                color: textColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        for (final li in data.value)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: eff.BulletItemView(
              type: type ?? eff.BulletType.unListed,
              child: Text(
                li,
                style: textTheme.bodyLarge?.copyWith(color: textColor),
              ),
            ),
          ),
      ],
    );
  }
}
