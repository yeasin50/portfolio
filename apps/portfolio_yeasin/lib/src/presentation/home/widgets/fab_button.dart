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
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: () {
          final controller = PrimaryScrollController.maybeOf(context);
          controller?.animateTo(
            0,
            duration: Durations.extralong4,
            curve: Curves.easeOutBack,
          );
        },
        child: const eff.SphereView(
          colors: [Colors.white, Colors.transparent],
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Icon(
              Icons.home,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

@Deprecated("DONT use it ; need work")
class HomeFabLocation extends FloatingActionButtonLocation {
  const HomeFabLocation(this.controller);

  final ScrollController controller;
  @override
  Offset getOffset(ScaffoldPrelayoutGeometry scaffoldGeometry) {
    final currentPosition = controller.offset;
    final maxExtent = controller.position.maxScrollExtent;
    final viewPortHeight = controller.positions.first.viewportDimension;

    if (currentPosition < maxExtent - viewPortHeight) {
      return Offset(scaffoldGeometry.scaffoldSize.width / 2,
          scaffoldGeometry.scaffoldSize.height / 2);
    }
    if (currentPosition < 100)
      return Offset.zero;
    else
      return Offset(124, 124);
  }
}

class HomeFabAnimation extends FloatingActionButtonAnimator {
  @override
  Offset getOffset(
      {required Offset begin, required Offset end, required double progress}) {
    // TODO: implement getOffset
    throw UnimplementedError();
  }

  @override
  Animation<double> getRotationAnimation({required Animation<double> parent}) {
    // TODO: implement getRotationAnimation
    throw UnimplementedError();
  }

  @override
  Animation<double> getScaleAnimation({required Animation<double> parent}) {
    // TODO: implement getScaleAnimation
    throw UnimplementedError();
  }
}
