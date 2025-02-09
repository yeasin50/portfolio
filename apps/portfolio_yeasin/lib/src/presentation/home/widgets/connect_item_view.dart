import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../../../app/app.dart';

/// simple Circle IconBUttons of [Connect]
/// has simple hover opacity .75 -> 1.0 over [Connect.url] image
///
class ConnectButton extends StatefulWidget {
  const ConnectButton({
    super.key,
    required this.connect,
    required this.onHovered,
    required this.onTap,
  });

  final Connect connect;
  final ValueChanged<bool> onHovered;
  final VoidCallback onTap;

  @override
  State<ConnectButton> createState() => _ConnectButtonState();
}

class _ConnectButtonState extends State<ConnectButton>
    with SingleTickerProviderStateMixin {
  late final message =
      "${widget.connect.url} ${widget.connect.description ?? ""}";

  late AnimationController controller = AnimationController(
    vsync: this,
    duration: Durations.short4,
    lowerBound: .65,
    upperBound: 1,
  );

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ConnectThemeExt theme =
        Theme.of(context).extension<ConnectThemeExt>()!;

    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return Transform.scale(
          scale: controller.value + .25, //why complicate 😂
          child: child,
        );
      },
      child: Material(
        clipBehavior: Clip.hardEdge,
        shape: const CircleBorder(),
        color: theme.background,
        child: Tooltip(
          message: message,
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.only(top: 16),
          textStyle: theme.hintTextStyle,
          decoration: BoxDecoration(
            color: theme.hintBackgroundColor,
          ),
          child: InkWell(
            hoverColor: theme.hoverColor,
            onTap: widget.onTap,
            onHover: (v) {
              v ? controller.forward() : controller.reverse();
              widget.onHovered;
            },
            customBorder: const CircleBorder(),
            child: Image.network(
              widget.connect.logo,
              height: 48,
              width: 48,
              fit: BoxFit.cover,
              opacity: controller,
              errorBuilder: (context, error, stackTrace) => const Icon(
                Icons.error,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
