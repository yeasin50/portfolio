part of '../widgets/option_view.dart';

Alignment optionAlign({
  required Size canvasSize,
  required Size globeSize,
  required Offset globeOffset,
  required Offset cursorPosition,
}) {
  final globeCenter =
      globeOffset + Offset(globeSize.width / 2, globeSize.height / 2);

  double dx = (cursorPosition.dx - globeCenter.dx) / (canvasSize.width / 2);
  double dy = (cursorPosition.dy - globeCenter.dy) / (canvasSize.height / 2);

  if (dx > 1.0) dx = 1.0;
  if (dy > 1.0) dy = 1.0;
  if (dx < -1.0) dx = -1.0;
  if (dy < -1.0) dy = -1.0;

  if (dx < -1.0) dx = -0.9;
  if (dy < -1.0) dy = -0.9;
  if (dx > 1.0) dx = 0.9;
  if (dy > 1.0) dy = 0.9;

  return Alignment(dx, dy);
}
