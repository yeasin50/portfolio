import 'package:effects/effects.dart' as eff;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:contact/contact.dart';
import 'package:portfolio_yeasin/src/presentation/home/home_page.dart';

import '../presentation/_common/viewport_requirement_page.dart';
import 'app_theme.dart';

class AppRouter {
  final uri = Uri.base;

  static String homeRoute = "/";
  static String workRoute = "/work";
  static String getInTouch = "/get_in_touch";

  // we can't have path_parameter in githubPage, so it tricks to navigate to the contactPage if needed
  // http://localhost:40879/#?ping
  final ValueNotifier<int> _refresher = ValueNotifier(1);

  void notify() {
    _refresher.value++;
  }

  String? _redirect(BuildContext context, GoRouterState state) {
    final query = state.uri.queryParameters;
    final navToTouch = query.keys.contains("ping");
    debugPrint(
      "redirect ${_refresher.value} state  query: ${state.uri.queryParameters.toString()}  "
      "path: ${state.pathParameters.toString()}"
      "URI base ${Uri.base}"
      "loc ${state.matchedLocation}",
    );

    final route = state.matchedLocation;
    return route != getInTouch && navToTouch ? getInTouch : null;
  }

  GoRouter router(BuildContext context) {
    return GoRouter(
      initialLocation: '${uri.path}${uri.hasQuery ? '?${uri.query}' : ''}',
      refreshListenable: _refresher,
      redirect: _redirect,
      redirectLimit: 2,
      initialExtra: true,
      routes: [
        ShellRoute(
          routes: [
            GoRoute(
              path: homeRoute,
              builder: (context, state) {
                if (state.extra != null) _refresher.value += 1;
                return HomePage();
              },
              routes: [
                GoRoute(
                  path: getInTouch.replaceFirst("/", ""),
                  builder: (context, state) => ContactFormPage(
                    onBack: () {
                      context.canPop() ? context.pop() : context.go(homeRoute);
                    },
                  ),
                ),
              ],
            ),
          ],
          builder: (context, state, child) {
            final colors = Theme.of(
              context,
            ).extension<AppTheme>()!.backgroundGradient;
            final bool ignorePageSizeRequirement =
                state.fullPath?.contains("get_in_touch") ?? false;
            debugPrint(
              "builder wrapper $ignorePageSizeRequirement : " +
                  state.fullPath.toString(),
            );
            return eff.BackgroundView(
              key: const ValueKey("BG painter"),
              colors: colors,
              child: ignorePageSizeRequirement
                  ? child
                  : ViewportRequirementPage(child: child),
            );
          },
        ),
      ],
    );
  }
}
