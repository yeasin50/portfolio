import 'package:flutter/material.dart';
import 'package:portfolio_yeasin/src/infrastructure/provider.dart';
import '../../home/widgets/home_item_sliver_builder.dart';

import '../../../app/app.dart';
import '../../home/widgets/title_view.dart';

class ProjectConnectPage extends StatefulWidget {
  const ProjectConnectPage({super.key});

  @override
  State<ProjectConnectPage> createState() => _ProjectConnectPageState();
}

class _ProjectConnectPageState extends State<ProjectConnectPage> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final textColor = Theme.of(context).extension<AppTheme>()!.primaryText;

    const divider = SliverToBoxAdapter(child: Divider(height: 56));

    final data = provider.connectData;

    return Scaffold(
      body: data == null
          ? const Center(
              //todo: error page
              child: Text("Check Home"),
            )
          : CustomScrollView(
              slivers: [
                const SliverToBoxAdapter(child: SizedBox(height: 56)),
                TitleView.large(
                  title: data.title,
                  isSliver: true,
                ),
                for (final item in data.preferenceItems) ...[
                  HomeItemSliverBuilder(
                    title: item.title,
                    children: [
                      if (item.description.isNotEmpty)
                        Text(
                          item.description,
                          style:
                              textTheme.bodyLarge?.copyWith(color: textColor),
                        ),
                    ],
                  ),
                  divider,
                ]
              ],
            ),
    );
  }
}
