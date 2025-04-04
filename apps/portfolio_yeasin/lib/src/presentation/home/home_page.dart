import 'package:core/core.dart';
import 'package:experience/experience.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:portfolio_yeasin/src/infrastructure/provider.dart';
import 'package:portfolio_yeasin/src/presentation/home/widgets/home_item_sliver_builder.dart';
import 'package:portfolio_yeasin/src/presentation/home/widgets/skill_items.dart';

import 'package:stackoverflow_stats/stackoverflow_stats.dart' as so;
import '../../infrastructure/utils/stack_overflow_user_mixin.dart';
import '../work/work_items.dart';
import 'widgets/intro_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static String route = "/";

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin, StackOverflowMixin {
  late final scrollController = PrimaryScrollController.of(context);

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

  late final soInfo = getSOId(context.provider.connects);
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    final hasExceedMaxWidth =
        MediaQuery.sizeOf(context).width < Spacing.maxWidth;
    return Scaffold(
      body: Listener(
        onPointerSignal: onPointerSignal,
        child: CustomScrollView(
          controller: scrollController,
          //! DOES not work,
          // physics: animationController.isAnimating
          //     ? null
          //     : IntroSnapScrollPhysics(snapHeight: size.height),

          slivers: [
            SliverPersistentHeader(
              pinned: !hasExceedMaxWidth,
              delegate: IntroPersistenceHeaderDelegate(
                info: provider.intro,
                maxHeight: size.height,
                minHeight: minIntroHeight,
              ),
            ),
            if (soInfo.$1 != null)
              HomeItemSliverBuilder(
                title: "StackOverflow",
                children: [
                  so.SoProfileView(
                    userId: soInfo.$1!,
                    description: soInfo.$2,
                  ),
                ],
              ),
            HomeItemSliverBuilder(
              title: "Experience",
              children: provider.experiences.map(
                (e) => ExperienceItemBuilder(experience: e),
              ),
            ),
            const HomeItemSliverBuilder(
              title: "Work",
              children: [
                WorkItems(maxItem: 4),
              ],
            ),
            HomeItemSliverBuilder(
              title: "Certificate",
              children: [
                CertificateListView(
                  certificates: provider.certificates,
                )
              ],
            ),
            const HomeItemSliverBuilder(
              title: "Skills",
              children: [
                SkillItems(),
              ],
            ),
            HomeItemSliverBuilder(
              title: "Education",
              children: provider.educations.map(
                (e) => EducationItemBuilder(
                  education: e,
                ),
              ),
            ),
          ]
              .map(
                (e) => SliverPadding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                  sliver: e,
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
