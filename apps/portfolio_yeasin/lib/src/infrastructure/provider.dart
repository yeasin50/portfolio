import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:contact/contact.dart';

import 'package:portfolio_yeasin/src/infrastructure/user_repository.dart';

import '../app/app_config.dart';

extension ProviderExt on BuildContext {
  UserRepository get provider => AppProvider.of(this, listen: false).repo;
  AppConfig get appConfig => AppProvider.of(this, listen: false).config;
}

extension AppStateExt<T extends StatefulWidget> on State<T> {
  UserRepository get provider => context.provider;
  AppConfig get appConfig => context.appConfig;
}

/// Actually I could just use [findAncestorWidgetOfExactType]
/// Ok  the placement is a mistake, fix later
class AppProvider extends InheritedWidget {
  AppProvider({
    super.key,
    required this.repo,
    required this.config,
    required Widget child,
  }) : super(
         child: MultiBlocProvider(
           providers: [
             BlocProvider(
               create: (context) => GetInTouchCubit(repo: repo.connectData!),
             ),
           ],
           child: child,
         ),
       );

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
