import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../presentation/home/home_page.dart';
import '../presentation/_common/widgets/background_view.dart';

import 'app_theme.dart';

class YeasinPortfolio extends StatelessWidget {
  const YeasinPortfolio({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppThemeConfig.data(AppThemeMode.light),
      scrollBehavior: const ScrollBehavior().copyWith(
        dragDevices: {
          PointerDeviceKind.mouse,
          PointerDeviceKind.touch,
          PointerDeviceKind.stylus,
          PointerDeviceKind.unknown
        },
      ),
      home: const BackgroundView(
        child: HomePage(),
      ),
    );
  }
}
