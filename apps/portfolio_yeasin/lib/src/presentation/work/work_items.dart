import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:portfolio_yeasin/src/app/app.dart';

import 'widgets/project_tile.dart';

class WorkItems extends StatefulWidget {
  const WorkItems({super.key});

  @override
  State<WorkItems> createState() => _WorkItemsState();
}

class _WorkItemsState extends State<WorkItems> {
  final items = List.filled(
    7,
    ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 500),
      child: ProjectTile(
        tileType: ProjectTileType.grid,
        project: Project.ui,
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    final itemPerRow =
        MediaQuery.sizeOf(context).width < Spacing.maxWidth ? 1 : 2;

    return Column(
      spacing: 32,
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
            )
        ]
      ],
    );
  }
}
