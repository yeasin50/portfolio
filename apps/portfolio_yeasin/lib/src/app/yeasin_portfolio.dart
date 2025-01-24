import 'package:flutter/material.dart';
import '../presentation/home/home_page.dart';
import '../presentation/widgets/background_view.dart';

import 'app_theme.dart';

class YeasinPortfolio extends StatelessWidget {
  const YeasinPortfolio({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppThemeConfig.data(AppThemeMode.light),
      home: const BackgroundView(
        child: HomePage(),
      ),
    );
  }
}
