import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../_common/utils/snap_physics.dart';
import 'widgets/intro_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  ///

  final IntroInfo info = const IntroInfo(
    name: "Md. Yeasin Sheikh",
    title: "Software Developer | Flutter specialist",
    shortTitle: "Software Developer | Flutter",
  );

  final scrollController = ScrollController();

  double minIntroHeight = 150;

  late final AnimationController animationController = AnimationController(
    vsync: this,
    duration: Durations.medium3,
    upperBound: MediaQuery.sizeOf(context).height,
    lowerBound: 0,
  )..addListener(
      () => scrollController.jumpTo(animationController.value),
    );

  /// Mouse scroll doesn't listen by scrollPhysics.
  /// That's why we need it
  void onPointerSignal(PointerSignalEvent event) {
    if (animationController.isAnimating) return;
    if (event is PointerScrollEvent) {
      if (event.scrollDelta.dy > 0) {
        animationController.forward();
      } else {
        animationController.reverse();
      }
    }
  }

  @override
  void dispose() {
    animationController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    return Scaffold(
        body: Listener(
      onPointerSignal: onPointerSignal,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: CustomScrollView(
          controller: scrollController,
          physics: IntroSnapScrollPhysics(snapHeight: size.height),
          slivers: [
            SliverPersistentHeader(
              pinned: true,
              delegate: IntroPersistenceHeaderDelegate(
                info: info,
                maxHeight: size.height,
                minHeight: minIntroHeight,
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: size.height * 3,
              ),
            )
          ],
        ),
      ),
    ));
  }
}
