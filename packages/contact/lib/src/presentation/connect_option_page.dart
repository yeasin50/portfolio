import 'package:contact/src/presentation/widgets/connect_option_header_delegate.dart';
import 'package:flutter/material.dart';
import 'package:core/core.dart' as core;

import '../../contact.dart';

import 'package:effects/effects.dart' as eff;

import 'widgets/schedule_view.dart';
import 'widgets/tldr_builder.dart';

///  show the details of [ConnectOption] in a separate page
///  use ripple route on parent
///
class ConnectOptionPage extends StatefulWidget {
  const ConnectOptionPage._({
    required this.option,
    required this.plasmaData,
  });

  final ConnectOption option;

  ///TODO:  In future, gonna test of this plasma if it is cool to add on BG
  final eff.SpherePlasmaData plasmaData;

  static eff.RippleRoute route({
    required ConnectOption option,
    required FractionalOffset animateTO,
    FractionalOffset? animateFrom,
    Duration pushDuration = const Duration(seconds: 1),
    Duration? popDuration,
    Color primaryColor = Colors.white,
    required eff.SpherePlasmaData plasmaData,
  }) {
    final route = eff.RippleRoute(
      builder: (context) => ConnectOptionPage._(
        option: option,
        plasmaData: plasmaData,
      ),
      center: animateTO,
      popPosition: animateFrom ?? animateTO,
      duration: pushDuration,
      popDuration: popDuration ?? pushDuration,
      color: primaryColor,
    );
    return route;
  }

  @override
  State<ConnectOptionPage> createState() => _ConnectOptionPageState();
}

class _ConnectOptionPageState extends State<ConnectOptionPage> {
  late final ScrollController _scrollController =
      PrimaryScrollController.of(context);

  double scrollProgress = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.addListener(listener);
    });
  }

  void listener() {
    scrollProgress =
        _scrollController.offset / _scrollController.position.maxScrollExtent;
  }

  @override
  void dispose() {
    _scrollController.removeListener(listener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: eff.BackgroundView(
        colors: [
          Color(0xFF1E2036),
          Color(0xFF343C59),
        ],
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverPersistentHeader(
              pinned: true,
              delegate: ConnectOptionHeaderDelegate(
                title: widget.option.name,
              ),
            ),
            SliverLayoutBuilder(
              builder: (context, constraints) {
                return SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if ((widget.option.tldr ?? "")
                          .isNotEmpty) //shift tldr builder
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
                                  TldrBuilder(text: widget.option.tldr!),
                                  if (widget.option.showSchedule)
                                    ScheduleView(
                                      schedules: widget.option.schedules,
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      for (final item in widget.option.principles)
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
          ]
              .map((e) => SliverPadding(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    sliver: e,
                  ))
              .toList(),
        ),
      ),
    );
  }
}
