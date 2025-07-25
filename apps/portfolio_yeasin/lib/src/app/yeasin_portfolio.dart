import 'package:contact/contact.dart';
import 'package:effects/effects.dart';
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
            return _ErrorView(msg: snapshot.error.toString());
          }

          return AppProvider(
            config: widget.config,
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
              // ConnectOptionPage(
              //   option: snapshot.requireData.connectData!.items[1],
              //   plasmaData: SpherePlasmaData.BJF,
              // ),
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

class _ErrorView extends StatelessWidget {
  const _ErrorView({
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
