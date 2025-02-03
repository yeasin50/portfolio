import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../stackoverflow_stats.dart';

import 'dart:math' as math;

import '../badge_label_chip.dart';

part 'home_page_delegate.dart';

class SoPageView extends StatefulWidget {
  const SoPageView({
    super.key,
    required this.userId,
  });
  final int userId;

  @override
  State<SoPageView> createState() => _SoPageViewState();
}

class _SoPageViewState extends State<SoPageView>
    with SingleTickerProviderStateMixin {
  //
  late final AnimationController controller;

  List<SOBadge> badges = [];

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 10),
    );

    SOUserRepo().getBadges(widget.userId).then(
      (value) {
        badges = value; // yea futureBuilder 🙄
        print(value);
        setState(() {});
        // controller.repeat();
      },
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Test"),
      ),
      body: InteractiveViewer(
        child: Flow(
          delegate: _SOFlowDelegate(
            animation: controller,
            badges: badges.sublist(0, 2),
          ),
          children: [
            // SoProfileView(userId: widget.userId),
            for (final b in badges) //
              BadgeLabelChip(badge: b),
          ],
        ),
      ),
    );
  }
}
