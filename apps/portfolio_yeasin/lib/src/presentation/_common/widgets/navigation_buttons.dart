import 'package:contact/contact.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:portfolio_yeasin/src/infrastructure/infrastructure.dart';

import '../../../app/theme/theme.dart';
import '../../home/home_page.dart';
import 'navigation_delegate.dart';

enum Page {
  home("Anchor"),
  work("The Forge"),
  about("The Story"),
  contact("Bridges"),
  ;

  const Page(this.label);

  final String label;
}

///  should get full constraints of parent widget in order to use [NavigationDelegate]
///
class NavigationButtons extends StatefulWidget {
  const NavigationButtons({
    super.key,
    required this.scrollT,
  });

  final double scrollT;

  @override
  State<NavigationButtons> createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationButtons>
    with SingleTickerProviderStateMixin {
  Page selectedPage = Page.home;

  late final scrollController = PrimaryScrollController.of(context);

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  void onTap(Page p) {
    if (p == Page.contact) {
      Navigator.of(context).push(
        ConnectPage.route(data: provider.connectData!),
      );
      return;
    }
    const speedFactor = 1;
    final currentOffset = scrollController.offset;

    final pageHeight = MediaQuery.sizeOf(context).height;

    final distanceToScroll = (switch (p) {
              Page.home => 0,
              Page.work => pageHeight,
              _ => 0,
            } -
            currentOffset)
        .abs();

    final duration = (distanceToScroll / speedFactor)
        .clamp(
          Durations.short1.inMilliseconds,
          Durations.extralong1.inMilliseconds,
        )
        .toInt();

    if (p == Page.home && currentOffset > 2) {
      scrollController.animateTo(
        0,
        duration: Duration(milliseconds: duration),
        curve: Curves.easeOutBack,
      );
    }

    if (p == Page.work && (currentOffset - pageHeight).abs() > 10) {
      scrollController.animateTo(
        pageHeight,
        duration: Duration(milliseconds: duration),
        curve: Curves.easeIn,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final hasExceedMaxWidth =
        MediaQuery.sizeOf(context).width < Spacing.maxWidth;

    final children = Page.values
        .map(
          (e) => NavigationItem(
            label: e.label,
            isActive: e == selectedPage,
            onTap: () => onTap(e),
          ),
        )
        .toList();
    return hasExceedMaxWidth
        ? Wrap(children: children)
        : Flow(
            delegate: NavigationDelegate(widget.scrollT),
            children: children,
          );
  }
}

///  simple chip  or button for different page
class NavigationItem extends StatefulWidget {
  const NavigationItem({
    super.key,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  final String label;
  final bool isActive;
  final VoidCallback onTap;

  @override
  State<NavigationItem> createState() => _NavigationItemState();
}

class _NavigationItemState extends State<NavigationItem> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final navTheme = theme.extension<NavigationTheme>()!;

    return InkWell(
      onTap: widget.onTap,
      customBorder: const StadiumBorder(),
      child: Material(
        color: widget.isActive
            ? //
            navTheme.activeColor
            : navTheme.inactiveColor,
        shape: const StadiumBorder(),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 32,
            vertical: 8,
          ),
          child: Text(
            widget.label,
            style: widget.isActive
                ? //
                navTheme.activeTextStyle
                : navTheme.inactiveTextStyle,
          ),
        ),
      ),
    );
  }
}
