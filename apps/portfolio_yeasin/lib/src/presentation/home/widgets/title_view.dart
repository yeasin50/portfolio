import 'package:flutter/material.dart';

import '../../../app/app.dart';

///  the header/title of each  topic inside [HomePage]
/// e.g.
class TitleView extends StatefulWidget {
  const TitleView({
    super.key,
    required this.title,
  });

  final String title;

  @override
  State<TitleView> createState() => _TitleViewState();
}

class _TitleViewState extends State<TitleView> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final textColor = Theme.of(context).extension<AppTheme>()!.primaryText;

    return Text(
      widget.title,
      style: textTheme.headlineSmall?.copyWith(
        color: textColor,
      ),
    );
  }
}
