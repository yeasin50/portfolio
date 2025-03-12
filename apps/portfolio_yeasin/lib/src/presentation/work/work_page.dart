import 'package:flutter/material.dart';
import 'package:core/core.dart';
import '../home/widgets/title_view.dart';
import 'work_items.dart';

class WorkPage extends StatefulWidget {
  const WorkPage({super.key});

  static PageRouteBuilder route() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) {
        return const WorkPage();
      },
      maintainState: true,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1.0, 0.0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        );
      },
    );
  }

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
                const Align(
                  alignment: Alignment.centerLeft,
                  child: BackButton(),
                ),
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
