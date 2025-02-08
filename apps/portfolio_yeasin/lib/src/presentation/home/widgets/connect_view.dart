import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:portfolio_yeasin/src/infrastructure/provider.dart';

import 'package:url_launcher/url_launcher.dart';
import '../../../app/app.dart';
import 'connects_flow_delegate.dart';

/// when the animation will start or will stopped
const _animationBreakPoint = .90;

///  some professional  profiles for portfolio
/// I wont recommend more than 4, use about section for more 
/// *  returns a [CustomMultiChildLayout] need to make sure
class ConnectView extends StatefulWidget {
  const ConnectView({
    super.key,
    required this.animationValue,
  });

  final double animationValue;

  @override
  State<ConnectView> createState() => _ConnectViewState();
}

class _ConnectViewState extends State<ConnectView>
    with SingleTickerProviderStateMixin {
  //
  late final AnimationController controller = AnimationController(
    vsync: this,
    duration: Durations.medium1,
  );

  late Animation animation = TweenSequence([
    TweenSequenceItem(
        tween: Tween(begin: 0.0, end: 1.3)
            .chain(CurveTween(curve: Curves.easeOut)),
        weight: 50),
    TweenSequenceItem(
        tween: Tween(begin: 1.3, end: 0.85)
            .chain(CurveTween(curve: Curves.easeInOut)),
        weight: 30),
    TweenSequenceItem(
        tween: Tween(begin: 0.85, end: 1.15)
            .chain(CurveTween(curve: Curves.easeOut)),
        weight: 25),
    TweenSequenceItem(
        tween: Tween(begin: 1.15, end: 0.95)
            .chain(CurveTween(curve: Curves.easeInOut)),
        weight: 20),
    TweenSequenceItem(
        tween: Tween(begin: 0.95, end: 1.0)
            .chain(CurveTween(curve: Curves.easeIn)),
        weight: 15),
  ]).animate(controller);

  @override
  void didUpdateWidget(covariant ConnectView oldWidget) {
    if (oldWidget.animationValue > _animationBreakPoint) {
      controller.forward();
    } else if (oldWidget.animationValue < _animationBreakPoint) {
      controller.reverse();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  late final List<Connect> data = context.provider.connects;

  void navToSite(String url) async {
    try {
      //why not canLaunch,
      launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    } catch (e) {
      //
    }
  }

  @override
  Widget build(BuildContext context) {
    return Flow(
      delegate: ConnectFlowDelegate(animation),
      clipBehavior: Clip.none,
      children: data
          .map(
            (e) => _ConnectButton(
              connect: e,
              onHovered: (v) {},
              onTap: () => navToSite(e.url),
            ),
          )
          .toList(),
    );
  }
}

class _ConnectButton extends StatefulWidget {
  const _ConnectButton({
    required this.connect,
    required this.onHovered,
    required this.onTap,
  });
  final Connect connect;
  final ValueChanged<bool> onHovered;
  final VoidCallback onTap;

  @override
  State<_ConnectButton> createState() => _ConnectButtonState();
}

class _ConnectButtonState extends State<_ConnectButton> {
  late final message =
      "${widget.connect.url} ${widget.connect.description ?? ""}";
  @override
  Widget build(BuildContext context) {
    final ConnectThemeExt theme =
        Theme.of(context).extension<ConnectThemeExt>()!;

    return Material(
      clipBehavior: Clip.hardEdge,
      shape: CircleBorder(
        side: BorderSide(
          color: theme.borderColor,
          width: 1,
        ),
      ),
      color: theme.background,
      child: Tooltip(
        message: message,
        child: InkWell(
          hoverColor: theme.hoverColor,
          onTap: widget.onTap,
          onHover: widget.onHovered,
          customBorder: const CircleBorder(),
          child: Image.network(
            widget.connect.logo,
            height: 32,
            width: 32,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => const Icon(
              Icons.error,
            ),
          ),
        ),
      ),
    );
  }
}
