import 'package:flutter/material.dart';
import 'package:effects/effects.dart' as eff;

import '../../../contact.dart';

///  Build list of Preference with hover effect
/// TODO: Make sure user has expand all
///
class PreferenceBuilder extends StatelessWidget {
  const PreferenceBuilder({
    super.key,
    required this.item,
  });

  final ConnectionPrinciple item;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<ContactThemeExt>()!;

    return eff.AnimatedExpansionTile(
      title: Text(
        item.title,
        style: theme.pageTitle,
      ),
      // initialExpanded: true,
      lowerBound: item.items.isEmpty ? .80 : .23,
      //     item.items.isEmpty && item.description.length < 300 ? 1 : .2,
      expandIconColor: theme.expandIconColor,
      children: [
        for (final li in item.items)
          Padding(
            padding: const EdgeInsets.only(bottom: 24),
            child: PrincipleItemBuilder(
              data: li,
              type: eff.BulletType.fromDomain(item.category),
            ),
          ),
      ],
    );
  }
}

class PrincipleItemBuilder extends StatelessWidget {
  ///
  const PrincipleItemBuilder({
    super.key,
    required this.data,
    required this.type,
  });

  final PrincipleInfo data;
  final eff.BulletType type;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<ContactThemeExt>()!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Text(
            data.name,
            style: theme.itemSubTitle,
          ),
        ),
        for (final li in data.data)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: eff.BulletItemView(
              type: type,
              bulletColor: type.color,
              child: Text(
                li,
                style: theme.itemStyle,
              ),
            ),
          ),
      ],
    );
  }
}
