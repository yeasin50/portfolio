import 'package:core/core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:portfolio_yeasin/src/infrastructure/user_repository.dart';
import 'package:portfolio_yeasin/src/presentation/home/home_page.dart';
import '../infrastructure/provider.dart';
import 'package:logger/logger.dart';
import 'package:effects/effects.dart' as eff;

import '../presentation/_common/error_page.dart';
import '../presentation/_common/viewport_requirement_page.dart';
import 'app_config.dart' show AppConfig;
import 'app_theme.dart';

class YeasinPortfolio extends StatefulWidget {
  const YeasinPortfolio({super.key, required this.config});
  final AppConfig config;

  @override
  State<YeasinPortfolio> createState() => _YeasinPortfolioState();
}

class _YeasinPortfolioState extends State<YeasinPortfolio> {
  late final Future<UserRepository> future = UserRepository.create(
    ApiConfig(
      baseUrl: widget.config.baseUrl,
      imageDir: widget.config.imageDir,
      iconDir: widget.config.iconDir,
      logger: Logger(),
      // logger: ,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserRepository>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const eff.BackgroundView(
            key: ValueKey("BG painter"),
            colors: [
              Color(0xFF1E2036), // Deep Blue-Gray
              Color(0xFF343C59), // Muted Slate Blue
            ],
            child: Center(),
          );
        }

        if (snapshot.hasError) {
          return ErrorView(msg: snapshot.error.toString());
        }

        return AppProvider(
          config: widget.config,
          repo: snapshot.requireData,
          child: MaterialApp(
            // showPerformanceOverlay: kDebugMode,
            theme: AppThemeConfig.data(AppThemeMode.dark),
            scrollBehavior: const ScrollBehavior().copyWith(
              dragDevices: PointerDeviceKind.values.toSet(),
            ),
            home: ViewportRequirementPage(child: const HomePage()),
            builder: (context, child) {
              final colors = Theme.of(
                context,
              ).extension<AppTheme>()!.backgroundGradient;
              return eff.BackgroundView(
                key: const ValueKey("BG painter"),
                colors: colors,
                child: child!,
              );
            },
          ),
        );
      },
    );
  }
}
