import 'package:flutter/material.dart';
import 'package:portfolio_yeasin/src/infrastructure/user_repository.dart';

extension ProviderExt on BuildContext {
  UserRepository get provider => AppProvider.of(this, listen: false);
}

extension GameStateExt<T extends StatefulWidget> on State<T> {
  UserRepository get provider => context.provider;
}

/// Actually I could just use [findAncestorWidgetOfExactType]

class AppProvider extends InheritedWidget {
  const AppProvider({
    super.key,
    required this.repo,
    required super.child,
  });

  final UserRepository repo;

  static UserRepository of(BuildContext context, {bool listen = true}) {
    if (listen) {
      return context.dependOnInheritedWidgetOfExactType<AppProvider>()!.repo;
    }
    return context.findAncestorWidgetOfExactType<AppProvider>()!.repo;
  }

  @override
  bool updateShouldNotify(covariant AppProvider oldWidget) {
    return oldWidget.repo != repo;
  }
}
