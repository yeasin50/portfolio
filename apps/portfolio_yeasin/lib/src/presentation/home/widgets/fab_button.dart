import 'package:flutter/material.dart';
import 'package:effects/effects.dart' as eff;

///  animate to top/ open  menu for [HomePage]  by replacing navigation button
///
class FabButton extends StatelessWidget {
  const FabButton({super.key, required this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 24.0, top: 24),
      child: eff.HomeIcon(onTap: onTap),
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
