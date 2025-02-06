import 'package:core/core.dart';
import 'package:experience/experience.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:portfolio_yeasin/src/presentation/home/widgets/skill_items.dart';
import 'package:stackoverflow_stats/stackoverflow_stats.dart' as so;

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
  ///
  int stackOverflowUserID = 10157127;

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

  final educations = [
    Education(
      school: const Organization(
        name: "Daffodil International University",
      ),
      degree: "Bachelor",
      field: "Computer Science and Engineering",
      start: DateTime(2018, 01),
      end: DateTime(2023, 09),
      grade: "3.67 out of 4.0",
      description: "this is a long description" * 23,
    ),
  ];

  final certificates = [
    Certificate(
      name: "Certified in FlutterDevcamp State Management",
      organization: Organization(
        name: "Google Developer Group, London",
      ),
      issueDate: DateTime(2023),
    ),
    Certificate(
        name: "Foundation of User Experience(UX) Designed",
        organization: Organization(
          name: "Google",
        ),
        issueDate: DateTime(2023),
        description: "desc " * 22),
    Certificate(
      name:
          "Completed the Microsoft Asia Virtual Experience Program in Engineering(Undergraduate & Masters)",
      organization: Organization(name: "Microsoft"),
      issueDate: DateTime(2021),
    ),
  ];

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
                padding: Spacing.group.copyWith(top: 0, bottom: 0),
                sliver: SliverMainAxisGroup(
                  slivers: [
                    const SliverAppBar.large(
                      title: Text("StackOverflow"),
                    ),
                    SliverToBoxAdapter(
                        child: Align(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints.tightFor(
                          width: Spacing.maxWidth,
                        ),
                        child: Center(
                          child: so.SoProfileView(userId: stackOverflowUserID),
                        ),
                      ),
                    )),
                  ],
                ),
              ),
              SliverPadding(
                padding: Spacing.group.copyWith(top: 0),
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
                    const SliverAppBar.large(),
                    SliverList.separated(
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 16,
                      ),
                      itemCount: educations.length,
                      itemBuilder: (context, index) {
                        return Center(
                          child: ConstrainedBox(
                            constraints: const BoxConstraints.tightFor(
                              width: Spacing.maxWidth,
                            ),
                            child: EducationItemBuilder(
                              education: educations[index],
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
                          child: CertificateListView(
                            certificates: certificates,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              //,
              SliverPadding(
                padding: Spacing.group,
                sliver: SliverToBoxAdapter(
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(
                        maxWidth: Spacing.maxWidth,
                      ),
                      child: const SkillItems(),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
