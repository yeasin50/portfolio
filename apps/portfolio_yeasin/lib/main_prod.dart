import 'package:flutter/material.dart';
import 'package:portfolio_yeasin/src/app/app_config.dart';

import 'src/app/yeasin_portfolio.dart';

void main() {
  runApp(
    const YeasinPortfolio(
      config: AppConfig.gitProd,
    ),
  );
}
