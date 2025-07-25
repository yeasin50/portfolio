import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../text_effect.dart';

@Deprecated("use ParagraphPainter instead.")
class AdvanceRichText extends StatefulWidget {
  const AdvanceRichText({
    super.key,
    required this.data,
    this.style = const TextStyle(),
    this.hoverTextStyle = const TextStyle(
      color: Colors.blue,
    ),
  });

  final List<ParagraphData> data;
  final TextStyle style;
  final TextStyle hoverTextStyle;

  @override
  State<AdvanceRichText> createState() => _AdvanceRichTextState();
}

class _AdvanceRichTextState extends State<AdvanceRichText> {
  /// launch [url] and on failure show snackbar
  void handleUrlLaunch(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else if (context.mounted) {
      debugPrint("failed to launch url");
      final snackBar = SnackBar(content: Text("failed to launch $url"));
      ScaffoldMessenger.maybeOf(context)?.showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: widget.data.mapIndexed(
          (i, e) {
            if (e.url != null) {
              return WidgetSpan(
                alignment: PlaceholderAlignment.baseline,
                baseline: TextBaseline.alphabetic,
                child: GestureDetector(
                  onTap: () => handleUrlLaunch(e.url!),
                  child: HoverAnimatedUnderline(
                    text: e.text,
                    textStyle: widget.style,
                    hoverStyle: widget.hoverTextStyle,
                  ),
                ),
              );
            }
            return TextSpan(
              text: e.text,
              style: widget.style,
            );
          },
        ).toList(),
      ),
    );
  }
}

class HoverAnimatedUnderline extends StatefulWidget {
  const HoverAnimatedUnderline({
    super.key,
    required this.text,
    required this.textStyle,
    required this.hoverStyle,
  });

  final String text;
  final TextStyle textStyle;
  final TextStyle hoverStyle;

  @override
  State<HoverAnimatedUnderline> createState() => _HoverAnimatedUnderlineState();
}

class _HoverAnimatedUnderlineState extends State<HoverAnimatedUnderline>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _underlineAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: Durations.medium1);
    _underlineAnimation =
        Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  void _onEnter(PointerEvent details) => _controller.forward();
  void _onExit(PointerEvent details) => _controller.reverse();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: _onEnter,
      onExit: _onExit,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Stack(
            alignment: Alignment.bottomLeft,
            children: [
              Text(
                widget.text,
                style: TextStyle.lerp(
                  widget.textStyle,
                  widget.hoverStyle,
                  _controller.value,
                ),
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  height: 2,
                  width: _underlineAnimation.value *
                      _textWidth(widget.text, widget.hoverStyle),
                  color: widget.hoverStyle.color,
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  double _textWidth(String text, TextStyle style) {
    final TextPainter painter = TextPainter(
      text: TextSpan(text: text, style: style),
      textDirection: TextDirection.ltr,
    )..layout();
    return painter.size.width;
  }
}
