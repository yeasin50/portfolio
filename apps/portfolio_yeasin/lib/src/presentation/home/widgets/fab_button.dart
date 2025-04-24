import 'package:flutter/material.dart';
import 'package:effects/effects.dart' as eff;

///  animate to top/ open  menu for [HomePage]  by replacing navigation button
///
class FabButton extends StatefulWidget {
  const FabButton({super.key});

  @override
  State<FabButton> createState() => _FabButtonState();
}

class _FabButtonState extends State<FabButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 24.0, top: 24),
      child: eff.HomeIcon(
        onTap: () {
          final controller = PrimaryScrollController.maybeOf(context);
          controller?.animateTo(
            0,
            duration: Durations.extralong4,
            curve: Curves.easeOutBack,
          );
        },
      ),
    );
  }
}

class FabCenterLocation extends FloatingActionButtonLocation {
  @override
  Offset getOffset(ScaffoldPrelayoutGeometry scaffoldGeometry) {
    final fabSize = scaffoldGeometry.floatingActionButtonSize;

    final dx = scaffoldGeometry.scaffoldSize.width / 2 - fabSize.width / 2;
    final dy = scaffoldGeometry.scaffoldSize.height / 2 - fabSize.height / 2;

    return Offset(dx, dy);
  }
}
