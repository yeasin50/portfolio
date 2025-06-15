import 'package:core/core.dart';
import 'package:flutter/material.dart';

/// shows dialog content in a [Overlay]
class ParagraphDialog extends StatefulWidget {
  ParagraphDialog({
    super.key,
    required this.data,
    this.animationDuration = Durations.medium4,
    this.animationAlignment = Alignment.bottomCenter,
  });

  final TextSpanDialogData data;
  final Duration animationDuration;
  final Alignment animationAlignment;

  static OverlayEntry? _entry;

  /// shows an overlay entry with [TextSpanDialogData]
  static Future<void> show({
    required BuildContext context,
    required TextSpanDialogData data,
    required Offset offset,
  }) async {
    final overlay = Overlay.of(context);

    _entry?.remove();
    _entry = OverlayEntry(
      builder: (context) {
        return Positioned(
          left: offset.dx,
          top: offset.dy,
          child: ParagraphDialog(data: data),
        );
      },
    );

    overlay.insert(_entry!);
  }

  @override
  State<ParagraphDialog> createState() => _ParagraphDialogState();
}

class _ParagraphDialogState extends State<ParagraphDialog> {
  double scale = 0;

  /// remove the overlay only if
  /// 1. Cursor is outside the overlay for 1.5s
  /// And 2. Cursor is not over the dialog span

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 200)).then((_) {
      scale = 1;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    return MouseRegion(
      onEnter: (_) {},
      onExit: (_) async {},
      child: AnimatedScale(
        duration: widget.animationDuration,
        alignment: widget.animationAlignment,
        scale: scale,
        child: Material(
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(widget.data.title, style: theme.titleMedium),
                for (final item in widget.data.items)
                  Text(item, style: theme.bodyMedium),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
