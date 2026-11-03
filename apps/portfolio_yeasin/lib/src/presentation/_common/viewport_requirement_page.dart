import 'package:flutter/material.dart';
import 'package:effects/effects.dart' as eff;
import '../../app/app.dart';

import '../home/widgets/widgets.dart' show ConnectsSimpleView;

/// Temporary widget until  I create mobile view which  I may not soon
class ViewportRequirementPage extends StatefulWidget {
  const ViewportRequirementPage({
    super.key,
    required this.child,
    this.minWidth = 720,
  });

  final Widget child;
  final double minWidth;

  @override
  State<ViewportRequirementPage> createState() =>
      _ViewportRequirementPageState();
}

class _ViewportRequirementPageState extends State<ViewportRequirementPage> {
  late bool hideChild = shouldHide;

  bool get shouldHide => MediaQuery.sizeOf(context).width < widget.minWidth;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    hideChild = shouldHide;
  }

  @override
  Widget build(BuildContext context) {
    return hideChild ? const _ViewPortWarn() : widget.child;
  }
}

class _ViewPortWarn extends StatelessWidget {
  const _ViewPortWarn();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final textColor = Theme.of(context).extension<AppTheme>()!.primaryText;

    return Scaffold(
      body: Padding(
        padding: const .all(24),
        child: Stack(
          children: [
            Center(
              child: AspectRatio(
                aspectRatio: 1,
                child: eff.PlasmaBallSphere(
                  data: eff.SpherePlasmaData.BJF,
                  intialAnimationValue: 1.0,
                ),
              ),
            ),

            Center(
              child: Column(
                mainAxisSize: .min,
                spacing: 24,
                children: [
                  eff.BulletView(
                    type: eff.BulletType.concern,
                    size: .square(32),
                    t: 1,
                  ),
                  eff.AnimatedArrowView(
                    child: Text(
                      "Tiny device? Nah",
                      style: textTheme.titleLarge?.copyWith(color: textColor),
                    ),
                  ),
                  Text(
                    "Try a larger screen or continue below",
                    style: textTheme.bodyLarge?.copyWith(
                      color: textColor,
                      fontWeight: .w500,
                    ),
                  ),
                  Flexible(
                    child: ConnectsSimpleView(animation: 1, isFlow: false),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
