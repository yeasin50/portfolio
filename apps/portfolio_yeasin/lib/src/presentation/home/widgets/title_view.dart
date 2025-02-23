import 'package:flutter/material.dart';

import '../../../app/app.dart';

///  the header/title of each  topic inside [HomePage]
/// e.g.
class TitleView extends StatefulWidget {
  const TitleView({
    super.key,
    required this.title,
    this.isExtraLarge = false,
  });

  factory TitleView.large({
    Key? key,
    required String title,
  }) =>
      TitleView(
        key: key,
        title: title,
        isExtraLarge: true,
      );

  final String title;

  /// if [isExtraLarge] is true textTheme.headlineLarge
  /// else textTheme.headlineSmall
  final bool isExtraLarge;

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
      style: (widget.isExtraLarge
              ? textTheme.headlineLarge
              : textTheme.headlineSmall)
          ?.copyWith(
        color: textColor,
      ),
    );
  }
}
