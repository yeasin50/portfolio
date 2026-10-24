import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:contact/contact.dart';
import 'package:portfolio_yeasin/src/presentation/home/home_page.dart';

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
                  if (context.canPop()) {
                    context.pop();
                  } else {
                    context.go(homeRoute);
                  }
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
