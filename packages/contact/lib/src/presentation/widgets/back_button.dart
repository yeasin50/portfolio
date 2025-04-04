import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:effects/effects.dart' as eff;

class BackHomeButton extends StatelessWidget {
  const BackHomeButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: Spacing.maxWidth,
      ),
      child: Align(
        alignment: Alignment.topLeft,
        child: eff.AnimatedBackButton(
          onTap: () => Navigator.of(context).pop(),
          child: Icon(Icons.home),
        ),
      ),
    );
  }
}
