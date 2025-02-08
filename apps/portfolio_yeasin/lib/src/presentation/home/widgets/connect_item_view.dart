import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../../../app/app.dart';

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

class _ConnectButtonState extends State<ConnectButton> {
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
        padding: const EdgeInsets.all(8),
        textStyle: theme.hintTextStyle,
        decoration: BoxDecoration(
          color: theme.hintBackgroundColor,
        ),
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
