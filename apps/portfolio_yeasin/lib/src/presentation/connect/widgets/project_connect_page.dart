import 'package:flutter/material.dart';
import 'package:portfolio_yeasin/src/infrastructure/provider.dart';

import 'package:effects/effects.dart' as eff;
import 'package:portfolio_yeasin/src/presentation/connect/widgets/preference_builder.dart';
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
                SliverLayoutBuilder(
                  builder: (context, constraints) {
                    return SliverToBoxAdapter(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          for (final item in data.preferenceItems)
                            Center(
                              child: ConstrainedBox(
                                constraints: const BoxConstraints.tightFor(
                                  width: Spacing.maxWidth,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 48.0),
                                  child: PreferenceBuilder(item: item),
                                ),
                              ),
                            )
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
    );
  }
}
