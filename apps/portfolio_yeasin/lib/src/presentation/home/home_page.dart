import 'package:core/core.dart';
import 'package:experience/experience.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../app/app.dart';
import '../work/work_items.dart';
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
    description:
        "A limited lifespan who loves to solve problems and create values.",
  );

  final experiences = List.generate(
    3,
    (index) => Experience(
      title: "Flutter Developer",
      company: const Organization(name: "organization"),
      start: DateTime(2020),
      description:
          "Created x with boost performance 20% which increased revenue \$12B",
    ),
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
    final pageHeight = MediaQuery.sizeOf(context).height;

    if (event is PointerScrollEvent) {
      if (event.scrollDelta.dy > 0 && scrollController.offset < pageHeight) {
        animationController.forward();
      } else if (scrollController.offset < pageHeight) {
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
            //! DOES not work,
            // physics: animationController.isAnimating
            //     ? null
            //     : IntroSnapScrollPhysics(snapHeight: size.height),

            slivers: [
              SliverPersistentHeader(
                pinned: true,
                delegate: IntroPersistenceHeaderDelegate(
                  info: info,
                  maxHeight: size.height,
                  minHeight: minIntroHeight,
                ),
              ),
              SliverPadding(
                padding: Spacing.group,
                sliver: SliverMainAxisGroup(
                  slivers: [
                    SliverAppBar.large(),
                    SliverList.separated(
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 16,
                      ),
                      itemCount: experiences.length,
                      itemBuilder: (context, index) {
                        return Center(
                          child: ConstrainedBox(
                            constraints: const BoxConstraints.tightFor(
                              width: Spacing.maxWidth,
                            ),
                            child: ExperienceItemBuilder(
                              experience: experiences[index],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              SliverPadding(
                  padding: Spacing.group,
                  sliver: SliverMainAxisGroup(
                    slivers: [
                      SliverAppBar.large(),
                      SliverToBoxAdapter(
                        child: Center(
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(
                              maxWidth: Spacing.maxWidth,
                            ),
                            child: const WorkItems(),
                          ),
                        ),
                      ),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
