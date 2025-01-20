import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project/src/project_info.dart';

enum ProjectTileType {
  //  date, title, roll and ...
  simple,

  /// title will be displayLarge
  /// date/category/roll with Large title
  titleLarge,
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

    final date = DateFormat("MMM.yyyy").format(p.createdAt);

    final title = Text(
      p.title,
      style: textTheme.titleLarge,
    );

    if (tileType == ProjectTileType.titleLarge) {
      return _ProjectTileLargeTitle(project: project);
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(date),
        const SizedBox(width: 12),
        title,
        const SizedBox(width: 12),
        Text("${p.category} / ${p.roll}"),
      ],
    );
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

    final date = DateFormat("MMM.yyyy").format(p.createdAt);
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
