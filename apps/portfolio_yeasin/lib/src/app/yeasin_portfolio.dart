import 'package:contact/contact.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:portfolio_yeasin/src/infrastructure/user_repository.dart';
import '../infrastructure/provider.dart';

import 'package:effects/effects.dart' as eff;

import 'app_theme.dart';

class YeasinPortfolio extends StatefulWidget {
  const YeasinPortfolio({super.key});

  @override
  State<YeasinPortfolio> createState() => _YeasinPortfolioState();
}

class _YeasinPortfolioState extends State<YeasinPortfolio> {
  late final Future<UserRepository> future = UserRepository.create();

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
              home: ConnectPage(
                data: snapshot.requireData.connectData!,
              ),

              builder: (context, child) {
                final colors = Theme.of(context) //
                    .extension<AppTheme>()!
                    .backgroundGradient;
                return eff.BackgroundView(
                  colors: colors,
                  child: child!,
                );
              },
            ),
          );
        });
  }
}
