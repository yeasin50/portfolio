import 'package:flutter/material.dart';
import 'package:effects/effects.dart' as eff;
import '../../contact.dart';

/// a simple sphere, contains a [label] string center
///
class OptionView extends StatefulWidget {
  const OptionView({
    super.key,
    required this.option,
    required this.onTap,
  });

  final OptionInfo option;
  final VoidCallback onTap;

  @override
  State<OptionView> createState() => _OptionViewState();
}

class _OptionViewState extends State<OptionView>
    with SingleTickerProviderStateMixin, eff.MouseTrackerMixin {
  //
  final GlobalKey _key = GlobalKey();
  Offset? _position;

  void findWidgetPosition() {
    final RenderBox? box =
        _key.currentContext?.findRenderObject() as RenderBox?;
    _position = box?.localToGlobal(Offset.zero);
  }

  late AnimationController controller = AnimationController(
    vsync: this,
    duration: Durations.short4,
  );

  @override
  void initState() {
    super.initState();
    onMouseMove = onMouseMovement;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      findWidgetPosition();
    });
  }

  Alignment lightAlign = Alignment.center;

  void onMouseMovement(Offset offset) {
    if (_position == null) return;
    //
    
    setState(() {});
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<ContactThemeExt>()!.optionTheme;

    return AnimatedBuilder(
      animation: Listenable.merge([controller]),
      builder: (context, child) {
        return CustomPaint(
          key: _key,
          painter: SpherePainter(
            lightAlignment: lightAlign,
            shades: widget.option.sphereColor ?? theme.optionGradient,
          ),
          child: child!,
        );
      },
      child: Center(
        child: Text(
          widget.option.label,
          style: theme.optionsTextStyle,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
