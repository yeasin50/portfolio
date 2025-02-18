import 'package:flutter/material.dart';

import '../contact.dart';
import 'sphere_painter.dart';

part 'option_alignment.dart';

class OptionView extends StatefulWidget {
  const OptionView({
    super.key,
    required this.label,
    required this.onTap,
    required this.lightAlign,
  });

  final String label;
  final VoidCallback onTap;
  final ValueNotifier<Alignment> lightAlign;

  @override
  State<OptionView> createState() => _OptionViewState();
}

class _OptionViewState extends State<OptionView>
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
    final theme = Theme.of(context).extension<ContactThemeExt>()!.optionTheme;

    return AnimatedBuilder(
      animation: Listenable.merge([controller, widget.lightAlign]),
      builder: (context, child) {
        return CustomPaint(
          painter: SpherePainter(
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
