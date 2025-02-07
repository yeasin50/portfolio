import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:portfolio_yeasin/src/infrastructure/user_repository.dart';
import '../infrastructure/provider.dart';
import '../presentation/home/home_page.dart';
import '../presentation/_common/widgets/background_view.dart';

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
              theme: AppThemeConfig.data(AppThemeMode.dark),
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
            ),
          );
        });
  }
}
