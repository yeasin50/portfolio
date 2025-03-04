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
            item.title,
            style: textTheme.headlineMedium?.copyWith(
              color: textColor,
            ),
          ),
          // initialExpanded: true,
          //TODO:: FIND A GOOD PATTERN
          lowerBound: item.items.isEmpty ? .80 : .23,
          //     item.items.isEmpty && item.description.length < 300 ? 1 : .2,
          children: [
            if (item.description.isNotEmpty)
              PreferenceDescriptionView(item.description),
            for (final li in item.items)
              PreferenceItemBuilder(text: li, type: item.type),
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
    required this.text,
    required this.type,
  });

  final String text;
  final eff.BulletType? type;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final textColor = Theme.of(context).extension<AppTheme>()!.primaryText;

    return eff.BulletItemView(
      type: type ?? eff.BulletType.unListed,
      child: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: 48),
        child: Text(
          text,
          style: textTheme.bodyLarge?.copyWith(color: textColor),
        ),
      ),
    );
  }
}

class PreferenceDescriptionView extends StatelessWidget {
  const PreferenceDescriptionView(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final textColor = Theme.of(context).extension<AppTheme>()!.primaryText;

    return Flexible(
      child: Text(
        text,
        style: textTheme.bodyLarge?.copyWith(color: textColor),
      ),
    );
  }
}
