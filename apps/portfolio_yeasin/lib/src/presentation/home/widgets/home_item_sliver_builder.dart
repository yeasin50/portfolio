import 'package:flutter/material.dart';

import '../../../app/app.dart';
import 'title_view.dart';

///  handle constraints , align and padding
/// * returns a Sliver
class HomeItemSliverBuilder extends StatelessWidget {
  const HomeItemSliverBuilder({
    super.key,
    required this.title,
    required this.children,
  });

  final String title;
  final Iterable<Widget> children;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.only(top: 72, bottom: 32),
      sliver: SliverLayoutBuilder(
        builder: (context, constraints) {
          return SliverToBoxAdapter(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints.tightFor(
                  width: Spacing.maxWidth,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  spacing: 24,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: TitleView(
                        title: title,
                      ),
                    ),
                    ...children,
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
