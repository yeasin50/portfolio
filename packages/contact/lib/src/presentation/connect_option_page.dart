import 'package:flutter/material.dart';
import 'package:core/core.dart' as c;

import '../../contact.dart';

import 'package:effects/effects.dart' as eff;

import 'widgets/tldr_builder.dart';

///  show the details of [ConnectOption] in a separate page
///  use ripple route on parent
class ConnectOptionPage extends StatelessWidget {
  const ConnectOptionPage({
    super.key,
    required this.option,
  });

  final ConnectOption option;

  static eff.RippleRoute route({
    required ConnectOption option,
    required FractionalOffset animateTO,
    FractionalOffset? animateFrom,
    Duration pushDuration = const Duration(seconds: 1),
    Duration? popDuration,
    Color primaryColor = Colors.blueAccent,
  }) {
    final route = eff.RippleRoute(
      builder: (context) => ConnectOptionPage(option: option),
      center: animateTO,
      popPosition: animateFrom ?? animateTO,
      duration: pushDuration,
      popDuration: popDuration ?? pushDuration,
      color: primaryColor,
    );
    return route;
  }

  /// todo
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(child: SizedBox(height: 56)), //handle it
          SliverToBoxAdapter(
            child: Text(
              option.name,
              style: Theme.of(context).extension<ContactThemeExt>()!.pageTitle,
            ),
          ),
          SliverLayoutBuilder(
            builder: (context, constraints) {
              return SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if ((option.tldr ?? "").isNotEmpty) //shift tldr builder
                      Center(
                        child: ConstrainedBox(
                          constraints: const BoxConstraints.tightFor(
                            width: c.Spacing.maxWidth,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 48.0),
                            child: TldrBuilder(
                              text: option.tldr!,
                            ),
                          ),
                        ),
                      ),
                    for (final item in option.principles)
                      Center(
                        child: ConstrainedBox(
                          constraints: const BoxConstraints.tightFor(
                            width: c.Spacing.maxWidth,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 48.0),
                            child: PreferenceBuilder(item: item),
                          ),
                        ),
                      )
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
