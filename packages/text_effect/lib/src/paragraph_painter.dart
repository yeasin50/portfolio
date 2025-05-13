import 'package:flutter/material.dart';

import '../text_effect.dart';

/// {@template paragraph_painter}
/// Renders text as a paragraph, avoiding issues caused by [WidgetSpan].
/// [WidgetSpan] treats content as a separate chunk, which breaks word wrapping
/// and forces words to move to the next line — an effect I want to avoid.
///
/// - use [data] to style specific textSpan
///
/// - [style] is the base [TextStyle] for the widget.
///
/// - [hoverTextStyle] used for the link-text of [data]
///
///! Note: Currently, when words wrap across lines, they are treated as separate
///! segments for rendering undines. not that good too. well expected :)
/// {@endtemplate}
///
/// {@tool snippet}
/// Example
///```dart
/// ParagraphPainter(
///   style: TextStyle(
///     color: Colors.black,
///     fontSize: 32,
///   ),
///   hoverTextStyle: TextStyle(
///     color: Colors.greenAccent,
///     fontSize: 32,
///   ),
///   data: [
///     TextSpanData(text: "Normal text"),
///     TextSpanData(text: " hover effect for link", url: "asd"),
///     TextSpanData(
///         text: "  extra something.... "),
///     TextSpanData(
///         text: "I am bold with url",
///         url: "asd",
///         bold: true),
///   ],
/// )
/// ```
///{@end-tool}
///
class ParagraphPainter extends StatefulWidget {
  /// {@macro paragraph_painter}
  const ParagraphPainter({
    super.key,
    required this.data,
    this.style = const TextStyle(),
    this.hoverTextStyle = const TextStyle(color: Colors.blue),
    this.hoverDuration = Durations.medium1,
  });

  /// text to shows with specific styles
  /// any style in it override the [style] or [hoverTextStyle] for
  /// -  bold, italic,
  final List<TextSpanData> data;

  /// base textStyle,  including the link text.
  /// If you want specific bold/italic,  use [data]
  ///
  final TextStyle style;

  ///
  final TextStyle hoverTextStyle;

  /// hover effect on link, default is [Durations.medium1]
  final Duration hoverDuration;

  @override
  State<ParagraphPainter> createState() => _ParagraphPainterState();
}

class _ParagraphPainterState extends State<ParagraphPainter>
    with SingleTickerProviderStateMixin {
  int? _hoveredOffset;

  late final controller = AnimationController(
    vsync: this,
    duration: widget.hoverDuration,
  );

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final maxWidth = constraints.maxWidth;

        final painter = ParagraphTextPainter(
          animation: controller,
          data: widget.data,
          baseStyle: widget.style,
          hoverStyle: widget.hoverTextStyle,
          hoveredOffset: _hoveredOffset,
        );

        final textPainter = TextPainter(
          text: painter.toTextSpan(),
          textDirection: TextDirection.ltr,
        );

        textPainter.layout(maxWidth: maxWidth);
        final height = textPainter.height;

        return MouseRegion(
          onHover: (event) {
            final localPosition = event.localPosition;
            textPainter.layout(maxWidth: maxWidth);
            final pos = textPainter.getPositionForOffset(localPosition).offset;

            if (_hoveredOffset != pos) {
              setState(() => _hoveredOffset = pos);
              controller.reset();
              controller.forward();
            }
          },
          onExit: (_) {
            setState(() => _hoveredOffset = null);
            controller.reverse();
          },
          child: CustomPaint(
            painter: painter,
            size: Size(maxWidth, height),
          ),
        );
      },
    );
  }
}

///  base painter class for the [ParagraphPainter]
///
class ParagraphTextPainter extends CustomPainter {
  ParagraphTextPainter({
    required this.data,
    required this.baseStyle,
    required this.hoverStyle,
    this.hoveredOffset,
    required this.animation,
  }) : super(repaint: animation);

  final List<TextSpanData> data;
  final TextStyle baseStyle;
  final TextStyle hoverStyle;

  final int? hoveredOffset;

  final Animation animation;

  TextSpan toTextSpan() {
    int offsetCounter = 0;

    return TextSpan(
      children: data.map((spanData) {
        final length = spanData.text.length;

        final isHovered = spanData.url != null &&
            hoveredOffset != null &&
            hoveredOffset! >= offsetCounter &&
            hoveredOffset! < offsetCounter + length;

        offsetCounter += length;

        return TextSpan(
          text: spanData.text,
          style: (isHovered
                  ? TextStyle.lerp(baseStyle, hoverStyle, animation.value)
                  : baseStyle)!
              .copyWith(
            fontWeight: spanData.bold == true ? FontWeight.bold : null,
            fontStyle: spanData.italic == true ? FontStyle.italic : null,
          ),
        );
      }).toList(),
    );
  }

  @override
  void paint(Canvas canvas, Size size) {
    final tp = TextPainter(
      text: toTextSpan(),
      textDirection: TextDirection.ltr,
    );

    tp.layout(maxWidth: size.width);
    tp.paint(canvas, Offset.zero);

    int offsetCounter = 0;
    for (final spanData in data) {
      final length = spanData.text.length;

      if (spanData.url != null &&
          hoveredOffset != null &&
          hoveredOffset! >= offsetCounter &&
          hoveredOffset! < offsetCounter + length) {
        final boxes = tp.getBoxesForSelection(
          TextSelection(
            baseOffset: offsetCounter,
            extentOffset: offsetCounter + length,
          ),
        );

        for (final box in boxes) {
          final underlineY = box.bottom;
          canvas.drawLine(
            Offset(box.left, underlineY),
            Offset(box.left + ((box.right - box.left) * animation.value),
                underlineY),
            Paint()
              ..color = hoverStyle.color ?? Colors.blue
              ..strokeWidth = 1.5,
          );
        }
      }

      offsetCounter += length;
    }
  }

  @override
  bool shouldRepaint(covariant ParagraphTextPainter oldDelegate) {
    return oldDelegate.hoveredOffset != hoveredOffset ||
        oldDelegate.data != data ||
        oldDelegate.baseStyle != baseStyle ||
        oldDelegate.hoverStyle != hoverStyle;
  }
}
