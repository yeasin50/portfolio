import 'package:core/core.dart';
import 'package:flutter/material.dart';
import './project_card.dart';
import 'project_card_3d.dart';

enum ProjectTileType {
  //  date, title, roll and ...
  simple,

  /// title will be displayLarge
  /// date/category/roll with Large title
  titleLarge,

  grid,
  grid3D,
}

class ProjectTile extends StatelessWidget {
  const ProjectTile({
    super.key,
    required this.project,
    this.tileType = ProjectTileType.simple,
  });

  final Project project;
  final ProjectTileType tileType;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final Project p = Project.ui;

    final date = PortfolioDateFormat.work(p.createdAt);

    final title = Text(
      p.title,
      style: textTheme.titleLarge,
    );

    return switch (tileType) {
      ProjectTileType.titleLarge => _ProjectTileLargeTitle(project: project),
      ProjectTileType.grid => ProjectCard(project: project),
      ProjectTileType.grid3D => ProjectCard3D(project: project),
      _ => Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(date),
            const SizedBox(width: 12),
            title,
            const SizedBox(width: 12),
            Text("${p.category} / ${p.roll}"),
          ],
        )
    };
  }
}

class _ProjectTileLargeTitle extends StatelessWidget {
  const _ProjectTileLargeTitle({required this.project});

  final Project project;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final Project p = Project.ui;

    final title = Text(
      p.title,
      style: textTheme.displayMedium,
    );

    final date = PortfolioDateFormat.work(p.createdAt);
    final subTitle = Text("$date / ${p.category} / ${p.roll}");

    final width = MediaQuery.sizeOf(context).width;

    return width < 800
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              title,
              subTitle,
            ],
          )
        : Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              subTitle,
              const SizedBox(width: 16),
              Expanded(child: title),
            ],
          );
  }
}
