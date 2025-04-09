import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:portfolio_yeasin/src/infrastructure/provider.dart';

import 'package:url_launcher/url_launcher.dart';
import 'connect_item_view.dart';
import 'connects_flow_delegate.dart';

/// when the animation will start or will stopped
///! but not needed for [SimpleConnectFlowDelete]
const _animationBreakPoint = .90;

///  some professional  profiles for portfolio
/// I wont recommend more than 4, use about section for more
/// *  returns a [CustomMultiChildLayout] need to make sure
@Deprecated(
  "Kinda messed up thinking what will looks good, "
  "use [ConnectsSimpleView] for the time being",
)
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
    duration: Duration(seconds: 3),
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
      delegate: ConnectFlowDelegate(
          Animation.fromValueListenable(ValueNotifier(widget.animationValue))),
      clipBehavior: Clip.none,
      children: data
          .map(
            (e) => ConnectButton(
              connect: e,
              onHovered: (v) {},
              onTap: () => navToSite(e.url),
            ),
          )
          .toList(),
    );
  }
}
