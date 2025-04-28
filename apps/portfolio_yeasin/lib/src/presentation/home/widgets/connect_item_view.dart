import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:effects/effects.dart' as eff;
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:portfolio_yeasin/src/infrastructure/provider.dart';
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
    final ActionThemeExt theme = Theme.of(context).extension<ActionThemeExt>()!;

    final String logoPath =
        "${context.appConfig.iconDir}${widget.connect.logo}";

    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return Transform.scale(
          scale: controller.value + .25, //why complicate 😂
          child: child,
        );
      },
      child: Material(
        clipBehavior: Clip.none,
        shape: const CircleBorder(),
        color: theme.background,
        child: InkWell(
          hoverColor: theme.hoverColor,
          onTap: widget.onTap,
          onHover: (v) {
            v ? controller.forward() : controller.reverse();
            widget.onHovered;
          },
          customBorder: const CircleBorder(),
          child: eff.SphereView(
            colors: [Colors.white.withAlpha(40), Colors.black12],
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Image.network(
                logoPath,
                height: 48,
                width: 48,
                fit: BoxFit.cover,
                opacity: controller,
                loadingBuilder: (context, child, loadingProgress) =>
                    loadingProgress != null
                        ? BlurHash(
                            hash: widget.connect.blurhash ??
                                "LDDK_B%\$vfTI?dVFabaLqDNEHrtQ",
                          )
                        : child,
                errorBuilder: (context, error, stackTrace) => const Icon(
                  Icons.error,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
