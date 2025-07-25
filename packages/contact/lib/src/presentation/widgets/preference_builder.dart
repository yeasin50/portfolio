import 'package:contact/src/presentation/widgets/tldr_builder.dart';
import 'package:flutter/material.dart';
import 'package:effects/effects.dart' as eff;

import '../../../contact.dart';

///  Build list of Preference with hover effect
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
      initialExpanded: true, // item.items.isEmpty,
      lowerBound: item.items.isEmpty ? .80 : .23,
      //     item.items.isEmpty && item.description.length < 300 ? 1 : .2,
      titlePadding: EdgeInsets.only(bottom: 8, top: 24),
      expandIconColor: theme.expandIconColor,
      children: [
        if (item.description.trim().isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: TldrBuilder(
              text: item.description,
            ),
          ),
        for (final li in item.items)
          Padding(
            padding: const EdgeInsets.only(bottom: 24),
            child: PrincipleItemBuilder(
              data: li,
              type: eff.BulletType.fromDomain(
                li.category.isNotEmpty ? li.category : item.category,
              ),
            ),
          ),
      ],
    );
  }
}

///  create simple listTile for[data] with bullet point.
///
/// handles [PrincipleInfo]'s description, strings,
///
/// ```dart
/// PrincipleItemBuilder(
///   data: li,
///   type: eff.BulletType.fromDomain(
///     li.category.isNotEmpty ? li.category : item.category,
/// ),
/// ```
///
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
      spacing: 12,
      children: [
        if (data.name.trim().isNotEmpty)
          Text(
            data.name,
            style: theme.itemSubTitle,
          ),
        if (data.description.trim().isNotEmpty)
          TldrBuilder(text: data.description),
        if (data.data.isNotEmpty)
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
