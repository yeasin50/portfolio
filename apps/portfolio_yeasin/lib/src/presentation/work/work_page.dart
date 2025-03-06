import 'package:flutter/material.dart';
import 'package:core/core.dart';
import '../home/widgets/title_view.dart';
import 'work_items.dart';

class WorkPage extends StatefulWidget {
  const WorkPage({super.key});

  @override
  State<WorkPage> createState() => _WorkPageState();
}

class _WorkPageState extends State<WorkPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 56),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints.tightFor(
              width: Spacing.maxWidth,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 48.0),
                  child: TitleView.large(
                    title: "Work",
                  ),
                ),
                const WorkItems(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
