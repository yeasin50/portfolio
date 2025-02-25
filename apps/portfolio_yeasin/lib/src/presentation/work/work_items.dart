import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:portfolio_yeasin/src/app/app.dart';
import 'package:portfolio_yeasin/src/infrastructure/provider.dart';

import 'package:effects/effects.dart' as eff;

import '../_common/widgets/filter_bar.dart';
import 'widgets/project_tile.dart';
import 'work_page.dart';

class WorkItems extends StatefulWidget {
  const WorkItems({
    super.key,
    this.maxItem,
    this.showFilter = false,
  });

  ///  if null, it will show all
  final int? maxItem;

  /// decide whether we should show the filter chip widget,
  /// default is `false`
  final bool showFilter;

  @override
  State<WorkItems> createState() => _WorkItemsState();
}

class _WorkItemsState extends State<WorkItems> {
  List<Project> filteredProjects = [];

  bool showSeeMore = false;

  List<String> filters = [];
  List<String> selectedFilter = [];
  void onFilterChanged(List<String> data) {
    filters = data;
    //todo: filter project: should I add more stuffs like language/framework based
    // or just device based --_---
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    final projects = context.provider.projects;
    final nbItem = (widget.maxItem == null || widget.maxItem! >= projects.length
            ? projects
            : projects.sublist(widget.maxItem!))
        .length;

    filteredProjects = projects.sublist(0, nbItem);

    filters = projects.map((e) => e.category).toSet().toList();
    selectedFilter = [...filters];

    showSeeMore = nbItem < projects.length;
  }

  Widget buildProject(Project e) => ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 500),
        child: ProjectTile(
          tileType: ProjectTileType.grid,
          project: e,
        ),
      );

  @override
  Widget build(BuildContext context) {
    final itemPerRow =
        MediaQuery.sizeOf(context).width < Spacing.maxWidth ? 1 : 2;

    return Column(
      spacing: 16,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // if (widget.showFilter)
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: FilterBar(
            items: filters,
            onChanged: onFilterChanged,
            initialSelected: selectedFilter,
          ),
        ),
        // nested for padding, lazy 😀
        Column(
          spacing: 48,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (itemPerRow == 1)
              ...filteredProjects.map((e) {
                return buildProject(e);
              })
            else ...[
              for (int i = 0;
                  i < filteredProjects.length + filteredProjects.length % 2;
                  i += 2)
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  spacing: 48,
                  children: [
                    buildProject(filteredProjects[i]),
                    if (i + 1 < filteredProjects.length)
                      buildProject(filteredProjects[i + 1]),
                  ],
                ),
            ]
          ],
        ),
        if (showSeeMore)
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
