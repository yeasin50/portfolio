import 'package:flutter/material.dart';

import 'package:effects/effects.dart' as eff;

import '../../../contact.dart';

///TODO:  some animation
///
class TldrBuilder extends StatelessWidget {
  const TldrBuilder({
    super.key,
    required this.text,
    this.title,
  });

  final String? title;
  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<ContactThemeExt>()!;
    return eff.AnimatedExpansionTile(
      title: Text(title ?? "", style: theme.pageTitle),
      initialExpanded: true,
      lowerBound: .23,
      children: [
        Text(text),
      ],
    );
  }
}
