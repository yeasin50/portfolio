import 'package:effects/effects.dart' as eff;
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:portfolio_yeasin/src/app/app_router.dart';

import '../app/app_theme.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key, required this.error});

  final GoException? error;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppTheme>()!;
    return eff.BackgroundView(
      key: const ValueKey("BG painter"),
      colors: colors.backgroundGradient,
      child: Scaffold(
        body: Stack(
          children: [
            Center(
              child: ConstrainedBox(
                constraints: .loose(Size.square(400)),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: eff.PlasmaBallSphere(
                    data: eff.SpherePlasmaData.HRS,
                    intialAnimationValue: 1,
                    child: Center(
                      child: eff.HomeIcon(
                        onTap: () => context.go(AppRouter.homeRoute),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            Align(
              alignment: Alignment(0, .25),
              child: Text(
                "404",
                style: TextStyle(color: Colors.white, fontSize: 48),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
