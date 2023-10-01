import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LinkTextView extends StatefulWidget {
  LinkTextView({
    super.key,
    required this.paragraph,
    this.url,
    this.linkText,
    this.onTap,
  })  : assert(
          linkText == null || paragraph.contains(linkText),
          'linkText must be null or must be contained in paragraph',
        ),
        assert(
          url != null || onTap != null,
          'url and onTap both cannot be null',
        );

  final String paragraph;
  final String? url;

  /// If [linkText] is null, [url] will be used as over paragraph.
  final String? linkText;

  /// Callback when the link is tapped. default it will launch the url in browser.
  final VoidCallback? onTap;
  @override
  State<LinkTextView> createState() => _LinkTextViewState();
}

class _LinkTextViewState extends State<LinkTextView> {
  late final TapGestureRecognizer _tapGestureRecognizer;

  List<TextSpan> spans = [];

  @override
  void initState() {
    super.initState();
    _tapGestureRecognizer = TapGestureRecognizer()
      ..onTap = widget.onTap ??
          () async {
            final uri = Uri.parse(widget.url!);
            if (await canLaunchUrl(uri)) {
              await launchUrl(uri);
            } else {
              throw 'Could not launch ${widget.url}';
            }
          };

    if (widget.linkText == null) {
      spans.add(
        TextSpan(
          text: widget.paragraph,
          style: const TextStyle(color: Colors.black),
          recognizer: _tapGestureRecognizer,
        ),
      );
    } else {
      final firstPart = widget.paragraph.substring(0, widget.paragraph.indexOf(widget.linkText!));
      final linkText = widget.linkText!;
      final lastPart = widget.paragraph.substring(widget.paragraph.indexOf(widget.linkText!) + widget.linkText!.length);

      spans.add(
        TextSpan(
          text: firstPart,
        ),
      );
      spans.add(
        TextSpan(
          text: linkText,
          style: const TextStyle(color: Colors.blue),
          recognizer: _tapGestureRecognizer,
        ),
      );

      spans.add(
        TextSpan(
          text: lastPart,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: spans,
      ),
    );
  }
}
