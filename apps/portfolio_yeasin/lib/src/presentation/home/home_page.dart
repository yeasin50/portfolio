import 'package:contact/contact.dart';
import 'package:core/core.dart';
import 'package:experience/experience.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:portfolio_yeasin/src/infrastructure/provider.dart';
import 'package:portfolio_yeasin/src/presentation/home/widgets/fab_button.dart';
import 'package:stackoverflow_stats/stackoverflow_stats.dart' as so;
import '../../infrastructure/utils/stack_overflow_user_mixin.dart';
import '../work/work_items.dart';
import 'widgets/widgets.dart';

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
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollController.addListener(scrollLister);
    });
  }

  FloatingActionButtonLocation? fabLoc;
  final fabCenter = FabCenterLocation();
  void scrollLister() {
    final currentPosition = scrollController.offset;
    final maxExtent = scrollController.position.maxScrollExtent;
    final viewPortHeight = scrollController.positions.first.viewportDimension;

    fabLoc = currentPosition < viewPortHeight
        ? null
        : currentPosition < maxExtent - 100
            ? FloatingActionButtonLocation.miniEndDocked
            : fabCenter;

    setState(() {});
  }

  @override
  void dispose() {
    animationController.dispose();
    scrollController.removeListener(scrollLister);
    super.dispose();
  }

  late final soInfo = getSOId(context.provider.connects);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    final hasExceedMaxWidth = MediaQuery.sizeOf(context).width <
        Spacing.maxWidth + Spacing.navBarPreserve * 3;

    return Scaffold(
      floatingActionButtonLocation: fabLoc,
      floatingActionButton: AnimatedBuilder(
        animation: scrollController,
        builder: (context, child) {
          if (fabLoc == null) return const SizedBox();
          return child!;
        },
        child: const FabButton(),
      ),
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
            if (soInfo.id != null)
              HomeItemSliverBuilder(
                title: "StackOverflow",
                children: [
                  so.SoProfileView(
                    userId: soInfo.id!,
                    description: soInfo.profile!.description,
                    textSpans: soInfo.profile!.textSpans,
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
            if (context.provider.connectData != null)
              SliverLayoutBuilder(
                builder: (context, constraints) {
                  return SliverToBoxAdapter(
                    child: SizedBox(
                      height: constraints.viewportMainAxisExtent,
                      child: const _ConnectInHomePage(),
                    ),
                  );
                },
              )
          ]
              .map(
                (e) => SliverPadding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 0),
                  sliver: e,
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}

/// Just simple view so that it looks good inside [HomePage]
class _ConnectInHomePage extends StatelessWidget {
  const _ConnectInHomePage();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 72, bottom: 8.0),
          child: Center(
            child: ConstrainedBox(
              constraints:
                  const BoxConstraints.tightFor(width: Spacing.maxWidth),
              child: const TitleView(title: "Get in touch for.."),
            ),
          ),
        ),
        if (context.provider.connectData != null)
          Expanded(
            child: ConnectPageBody(
              data: context.provider.connectData!,
            ),
          ),
      ],
    );
  }
}
