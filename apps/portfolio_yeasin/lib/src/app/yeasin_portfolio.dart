import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:portfolio_yeasin/src/infrastructure/user_repository.dart';
import 'package:portfolio_yeasin/src/presentation/home/home_page.dart';
import '../infrastructure/provider.dart';

import 'package:effects/effects.dart' as eff;

import 'app_config.dart';
import 'app_theme.dart';

class YeasinPortfolio extends StatefulWidget {
  const YeasinPortfolio({
    super.key,
    required this.config,
  });
  final AppConfig config;

  @override
  State<YeasinPortfolio> createState() => _YeasinPortfolioState();
}

class _YeasinPortfolioState extends State<YeasinPortfolio> {
  late final Future<UserRepository> future =
      UserRepository.create(widget.config);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserRepository>(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return AppProvider(
            repo: snapshot.requireData,
            child: MaterialApp(
              // showPerformanceOverlay: kDebugMode,
              theme: AppThemeConfig.data(AppThemeMode.dark),
              scrollBehavior: const ScrollBehavior().copyWith(
                dragDevices: {
                  PointerDeviceKind.mouse,
                  PointerDeviceKind.touch,
                  PointerDeviceKind.stylus,
                  PointerDeviceKind.unknown
                },
              ),
              home: const HomePage(),
              builder: (context, child) {
                final colors = Theme.of(context) //
                    .extension<AppTheme>()!
                    .backgroundGradient;
                return eff.BackgroundView(
                  key: const ValueKey("BG painter"),
                  colors: colors,
                  child: child!,
                );
              },
            ),
          );
        });
  }
}
