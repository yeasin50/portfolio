import 'package:core/core.dart';
import 'package:flutter/material.dart';

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
    final itemPerRow = MediaQuery.sizeOf(context).width < 1200 ? 1 : 2;

    return Column(
      spacing: 32,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: itemPerRow > 1
          ? CrossAxisAlignment.stretch
          : CrossAxisAlignment.center,
      children: [
        if (itemPerRow == 1)
          ...items
        else ...[
          for (int i = 0; i < items.length + items.length % 2; i += 2)
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
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
