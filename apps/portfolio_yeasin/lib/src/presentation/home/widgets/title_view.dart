import 'package:flutter/material.dart';
import 'package:core/core.dart';
import '../../../app/app.dart';

///  the header/title of each  topic inside [HomePage]
/// e.g.
class TitleView extends StatefulWidget {
  const TitleView({
    super.key,
    required this.title,
    this.isExtraLarge = false,
    this.isSliver = false,
  });

  factory TitleView.large({
    Key? key,
    required String title,
    bool isSliver = false,
  }) =>
      TitleView(
        key: key,
        title: title,
        isExtraLarge: true,
        isSliver: isSliver,
      );

  final String title;

  /// if [isExtraLarge] is true textTheme.headlineLarge
  /// else textTheme.headlineSmall
  final bool isExtraLarge;

  ///whether it should return as Sliver
  final bool isSliver;

  @override
  State<TitleView> createState() => _TitleViewState();
}

class _TitleViewState extends State<TitleView> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final textColor = Theme.of(context).extension<AppTheme>()!.primaryText;

    Widget textWidget = Text(
      widget.title,
      style: (widget.isExtraLarge
              ? textTheme.displayLarge
              : textTheme.headlineSmall)
          ?.copyWith(
        color: textColor,
      ),
    );

    if (widget.isSliver) {}

    return widget.isSliver
        ? SliverLayoutBuilder(
            builder: (context, constraints) {
              return SliverToBoxAdapter(
                child: Center(
                  child: ConstrainedBox(
                    constraints:
                        const BoxConstraints.tightFor(width: Spacing.maxWidth),
                    child: textWidget,
                  ),
                ),
              );
            },
          )
        : textWidget;
  }
}
