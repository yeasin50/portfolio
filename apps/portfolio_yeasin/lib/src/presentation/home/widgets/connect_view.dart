import 'package:flutter/material.dart';

import '../../../app/app.dart';
import 'connects_flow_delegate.dart';

/// when the animation will start or will stopped
const _animationBreakPoint = .90;

///  some professional  profiles for portfolio
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

  @override
  Widget build(BuildContext context) {
    final ConnectThemeExt theme =
        Theme.of(context).extension<ConnectThemeExt>()!;
    //
    return Flow(
      delegate: ConnectFlowDelegate(controller),
      children: [
        _ConnectButton(
          icon: Icon(
            Icons.email_rounded,
            color: theme.iconColor,
          ),
          onHovered: (value) {},
          onTap: () {},
        ),
        _ConnectButton(
          icon: Icon(
            Icons.ac_unit,
            color: theme.iconColor,
          ),
          onHovered: (value) {},
          onTap: () {},
        ),
        _ConnectButton(
          icon: Icon(
            Icons.access_alarms_sharp,
            color: theme.iconColor,
          ),
          onHovered: (value) {},
          onTap: () {},
        ),
        _ConnectButton(
          icon: Icon(
            Icons.account_tree_sharp,
            color: theme.iconColor,
          ),
          onHovered: (value) {},
          onTap: () {},
        ),
      ],
    );
  }
}

class _ConnectButton extends StatefulWidget {
  const _ConnectButton({
    required this.icon,
    required this.onHovered,
    required this.onTap,
  });
  final Widget icon;
  final ValueChanged<bool> onHovered;
  final VoidCallback onTap;

  @override
  State<_ConnectButton> createState() => _ConnectButtonState();
}

class _ConnectButtonState extends State<_ConnectButton> {
  @override
  Widget build(BuildContext context) {
    final ConnectThemeExt theme =
        Theme.of(context).extension<ConnectThemeExt>()!;
    return Material(
      shape: CircleBorder(
        side: BorderSide(
          color: theme.borderColor,
          width: 1,
        ),
      ),
      color: theme.background,
      child: InkWell(
        hoverColor: theme.hoverColor,
        onTap: widget.onTap,
        onHover: widget.onHovered,
        customBorder: const CircleBorder(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: widget.icon,
        ),
      ),
    );
  }
}
