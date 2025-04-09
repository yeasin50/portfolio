import 'package:flutter/material.dart';
import 'package:portfolio_yeasin/src/infrastructure/user_repository.dart';

import '../app/app_config.dart';

extension ProviderExt on BuildContext {
  UserRepository get provider => AppProvider.of(this, listen: false).repo;
  AppConfig get appConfig => AppProvider.of(this, listen: false).config;
}

extension GameStateExt<T extends StatefulWidget> on State<T> {
  UserRepository get provider => context.provider;
  AppConfig get appConfig => context.appConfig;
}

/// Actually I could just use [findAncestorWidgetOfExactType]

class AppProvider extends InheritedWidget {
  const AppProvider({
    super.key,
    required this.repo,
    required this.config,
    required super.child,
  });

  final UserRepository repo;
  final AppConfig config;

  static AppProvider of(BuildContext context, {bool listen = true}) {
    if (listen) {
      return context.dependOnInheritedWidgetOfExactType<AppProvider>()!;
    }
    return context.findAncestorWidgetOfExactType<AppProvider>()!;
  }

  @override
  bool updateShouldNotify(covariant AppProvider oldWidget) {
    return oldWidget.repo != repo;
  }
}
