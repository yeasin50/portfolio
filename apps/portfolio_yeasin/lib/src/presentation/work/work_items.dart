import 'package:flutter/material.dart';
import 'package:portfolio_yeasin/src/app/app.dart';
import 'package:portfolio_yeasin/src/infrastructure/provider.dart';

import 'package:effects/effects.dart' as eff;

import 'widgets/project_tile.dart';
import 'work_page.dart';

class WorkItems extends StatefulWidget {
  const WorkItems({
    super.key,
    this.maxItem,
  });

  ///  if null, it will show all
  final int? maxItem;

  @override
  State<WorkItems> createState() => _WorkItemsState();
}

class _WorkItemsState extends State<WorkItems> {
  late final projects = context.provider.projects;
  late final nbItem =
      (widget.maxItem == null || widget.maxItem! >= projects.length
              ? projects
              : projects.sublist(widget.maxItem!))
          .length;

  late final items = List.generate(
    nbItem,
    (i) => ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 500),
      child: ProjectTile(
        tileType: ProjectTileType.grid,
        project: projects[i],
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    final itemPerRow =
        MediaQuery.sizeOf(context).width < Spacing.maxWidth ? 1 : 2;

    return Column(
      spacing: 16,
      children: [
        // nested for padding, lazy 😀
        Column(
          spacing: 48,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (itemPerRow == 1)
              ...items
            else ...[
              for (int i = 0; i < items.length + items.length % 2; i += 2)
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  spacing: 48,
                  children: [
                    items[i],
                    if (i + 1 < items.length) items[i + 1],
                  ],
                ),
            ]
          ],
        ),
        if (nbItem < projects.length)
          Align(
            alignment: Alignment.centerLeft,
            child: eff.NeonButton(
              label: "see more",
              onTap: () {
                final route = MaterialPageRoute(
                  builder: (context) {
                    return WorkPage();
                  },
                );
                Navigator.of(context).push(route);
              },
            ),
          ),
      ],
    );
  }
}
