import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../../../app/app.dart';

class ProjectCard extends StatefulWidget {
  const ProjectCard({
    super.key,
    required this.project,
  });

  final Project project;

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard>
    with SingleTickerProviderStateMixin {
  late final project = widget.project;

  late final controller = AnimationController(
    vsync: this,
    duration: Durations.medium1,
    lowerBound: 0,
    upperBound: 16,
  )..addListener(() => setState(() {}));

  void onHover(_) {
    controller.forward(from: 0);
  }

  void onHoverExit(_) {
    controller.reverse();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cardTheme = Theme.of(context).extension<WorkCardTheme>()!;

    return InkWell(
      onTap: () {},
      hoverColor: Colors.transparent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          MouseRegion(
            onEnter: onHover,
            onExit: onHoverExit,
            child: DecoratedBox(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: cardTheme.bgColor,
                  boxShadow: [
                    BoxShadow(
                      color: cardTheme.hoverColor,
                      offset: const Offset(0, 0),
                      blurRadius: controller.value,
                      spreadRadius: controller.value,
                      blurStyle: BlurStyle.normal,
                    ),
                  ]),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  project.thumbnail,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Placeholder(),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16, bottom: 48),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  project.title,
                  style: cardTheme.titleStyle,
                ),
                Text(
                  project.category * 44,
                  textAlign: TextAlign.start,
                  softWrap: true,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: cardTheme.descriptionStyle,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
