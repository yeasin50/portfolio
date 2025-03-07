import 'package:contact/src/sphere_painter.dart';
import 'package:flutter/material.dart';

import '../contact.dart';

@Deprecated("Don't know where I am gonna use it,  remove later ")
class OptionViewV1 extends StatefulWidget {
  const OptionViewV1({
    super.key,
    required this.label,
    required this.onTap,
    required this.lightAlign,
  });

  final String label;
  final VoidCallback onTap;
  final ValueNotifier<Alignment> lightAlign;

  @override
  State<OptionViewV1> createState() => _OptionViewState();
}

class _OptionViewState extends State<OptionViewV1>
    with SingleTickerProviderStateMixin {
  late AnimationController controller = AnimationController(
    vsync: this,
    duration: Durations.short4,
  );

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme =
        Theme.of(context).extension<ContactThemeExtOLD>()!.optionTheme;

    return AnimatedBuilder(
      animation: Listenable.merge([controller, widget.lightAlign]),
      builder: (context, child) {
        return CustomPaint(
          painter: SpherePainterV1(
            lightAlignment: widget.lightAlign,
            shades: [
              Colors.blue,
              Colors.indigo,
              Colors.black,
            ],
          ),
          child: child!,
        );
      },
      child: Center(
        child: Text(
          widget.label,
          style: theme.optionsTextStyle,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
