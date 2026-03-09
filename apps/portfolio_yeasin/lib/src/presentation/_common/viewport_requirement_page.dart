import 'package:flutter/material.dart';
import 'package:effects/effects.dart' as eff;
import '../../app/app.dart';
import 'package:text_effect/text_effect.dart' as text_effect;

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
  @override
  Widget build(BuildContext context) {
    final hide = MediaQuery.sizeOf(context).width < widget.minWidth;
    return hide ? const _ViewPortWarn() : widget.child;
  }
}

class _ViewPortWarn extends StatefulWidget {
  const _ViewPortWarn({super.key});

  @override
  State<_ViewPortWarn> createState() => __ViewPortWarnState();
}

class __ViewPortWarnState extends State<_ViewPortWarn> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final textColor = Theme.of(context).extension<AppTheme>()!.primaryText;

    Text _buildText(String txt) {
      return Text(txt, style: textTheme.titleLarge?.copyWith(color: textColor));
    }

    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: AspectRatio(
              aspectRatio: 1,
              child: eff.PlasmaBallSphere(data: eff.SpherePlasmaData.BJF),
            ),
          ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              spacing: 24,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "I need more space",
                  style: textTheme.titleLarge?.copyWith(
                    color: textColor,
                    fontSize: 48,
                  ),
                ),
                Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints.tightFor(width: 350),
                    child: text_effect.ParagraphPainter(
                      style: textTheme.titleLarge!.copyWith(
                        color: textColor,
                        fontSize: 28,
                      ),
                      hoverTextStyle: textTheme.titleLarge!.copyWith(
                        color: Colors.greenAccent,
                        fontSize: 28,
                      ),
                      data: [
                        text_effect.ParagraphData(
                          text: "increase viewport",
                          url: "",
                        ),
                        text_effect.ParagraphData(text: ">720"),
                      ],
                    ),
                  ),
                ),
                eff.BulletView(
                  type: eff.BulletType.concern,
                  size: Size.square(24),
                  t: 1,
                ),
                eff.AnimatedArrowView(child: _buildText("change the device")),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
