import 'package:flutter/material.dart';

import '../../../app/app_theme.dart';

class BackgroundView extends StatefulWidget {
  const BackgroundView({
    super.key,
    required this.child,
    this.isDark = false,
  });

  final Widget child;
  final bool isDark;

  @override
  State<BackgroundView> createState() => _BackgroundViewState();
}

class _BackgroundViewState extends State<BackgroundView>
    with SingleTickerProviderStateMixin {
  late AnimationController controller = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 12),
    lowerBound: 0,
    upperBound: 6,
  )..repeat(reverse: true);

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  List<Color> get bgColors =>
      Theme.of(context).extension<AppTheme>()!.backgroundGradient;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) {
        setState(() {});
      },
      child: CustomPaint(
        painter: _BGPainter(
          animation: controller,
          colors: bgColors,
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            widget.child,
          ],
        ),
      ),
    );
  }
}

class _BGPainter extends CustomPainter {
  const _BGPainter({
    required this.animation,
    required this.colors,
  }) : super(repaint: animation);

  final Animation animation;
  final List<Color> colors;

  @override
  void paint(Canvas canvas, Size size) {
    final Gradient gradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: colors,
    );

    final Rect rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final Paint paint = Paint()..shader = gradient.createShader(rect);

    canvas.drawRect(rect, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
