import 'package:flutter/material.dart';
import 'package:core/core.dart' as core;

import '../../contact.dart';

import 'package:effects/effects.dart' as eff;

import 'widgets/schedule_view.dart';
import 'widgets/tldr_builder.dart';

///  show the details of [ConnectOption] in a separate page
///  use ripple route on parent
/// 
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
    Color primaryColor = Colors.white,
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
    final theme = Theme.of(context).extension<ContactThemeExt>()!;

    return Scaffold(
      body: eff.BackgroundView(
        colors: [
          Color(0xFF1E2036),
          Color(0xFF343C59),
        ],
        child: CustomScrollView(
          slivers: [
            SliverLayoutBuilder(
              builder: (context, constraints) {
                return SliverToBoxAdapter(
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints.tightFor(
                        width: core.Spacing.maxWidth,
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 48),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          spacing: 24,
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: eff.AnimatedBackButton(
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                                child: Icon(Icons.arrow_back_ios, size: 12),
                              ),
                            ),
                            Text(
                              option.name,
                              style: theme.pageTitle,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
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
                              width: core.Spacing.maxWidth,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 48.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                spacing: 24,
                                children: [
                                  TldrBuilder(text: option.tldr!),
                                  if (option.showSchedule)
                                    ScheduleView(schedules: option.schedules),
                                ],
                              ),
                            ),
                          ),
                        ),
                      for (final item in option.principles)
                        Center(
                          child: ConstrainedBox(
                            constraints: const BoxConstraints.tightFor(
                              width: core.Spacing.maxWidth,
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
      ),
    );
  }
}
