import 'package:flutter/material.dart';
import 'package:effects/effects.dart' as eff;

/// if something wrong on route or data 
class ErrorView extends StatelessWidget {
  const ErrorView({
    super.key,
    required this.msg,
  });
  final String msg;

  @override
  Widget build(BuildContext context) {
    return eff.BackgroundView(
      key: const ValueKey("BG  "),
      colors: const [
        Color(0xFF1E2036), // Deep Blue-Gray
        Color(0xFF343C59), // Muted Slate Blue
      ],
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Center(
          child: Text(msg),
        ),
      ),
    );
  }
}
