import 'package:flutter/material.dart';

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if ((title ?? "").isNotEmpty) Text(title ?? "", style: theme.pageTitle),
        if (text.trim().isNotEmpty)
          Text(
            text,
            style: theme.tldr,
          ),
      ],
    );
  }
}
