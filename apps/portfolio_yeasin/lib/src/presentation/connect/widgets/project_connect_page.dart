import 'package:flutter/material.dart';
import "package:effects/effects.dart" as eff;
import 'package:portfolio_yeasin/src/presentation/connect/widgets/list_item_builder.dart';
import '../../home/widgets/home_item_sliver_builder.dart';

import '../../../app/app.dart';
import '../../home/widgets/title_view.dart';

class ProjectConnectPage extends StatefulWidget {
  const ProjectConnectPage({super.key});

  @override
  State<ProjectConnectPage> createState() => _ProjectConnectPageState();
}

class _ProjectConnectPageState extends State<ProjectConnectPage> {
  final tldr =
      "I have worked on various types of projects for personal clients, companies, and government organizations throughout my development journey. Recents are under NDA, I will be happy if yours is not, but good ones are often lies here."
      " I often work as a part-time developer (20h/W) and take on additional contractual projects that require a few hours of maintenance each week."
      " The rest of the time, I enjoy learning new things and contributing on different platforms."
      " I also enjoy bug hunting and refactoring Flutter projects."
      " You will find me efficient in Flutter application development."
      " I prioritize working on ethical projects that align with my values and avoid anything that conflicts with my principles.";

  final List<String> thingsIDontWorkWith = [
    // Ethical Concerns
    "Projects that involve unethical hacking, illegal activities, or deceptive business models (e.g., pyramid schemes, get-rich-quick apps)",
    "Projects that violate privacy, security, or ethical guidelines",
    "Projects that violate Google Play or App Store policies",

    // Personal and Cultural Values
    "E-commerce or services related to haram products (e.g., bars, alcoholic drinks, tattoos, adult content, etc.)",
    "Teams or organizations where I will face pronoun issues (e.g., they/them)",

    // Industry and Type of Work
    "Any type of gambling or dating applications",
    "Crypto or NFT projects",

    // Work Environment
    "Toxic company culture or excessive workplace politics",
    "Clients looking for low-budget developers",
    "Companies that demand unrealistic deadlines with unfair compensation",
    "Micromanaging clients who don’t trust developers",

    // Scope, Documentation, and Clarity
    "Projects that lack clear vision, proper documentation, or realistic expectations",
    "Projects with a poorly defined or constantly changing scope",
    "Unpaid trial work or 'test tasks' before hiring",

    // Payment and Compensation
    "Equity-only payment models with no guaranteed compensation",
    "Clients who expect endless revisions without extra pay",

    // Client Relations
    "Non-technical clients who refuse to listen to expert advice",

    // Legal and Contractual Concerns
    "Excessive NDA or contract restrictions limiting future work (while I’m open to reasonable NDAs for sensitive projects)",

    // Fake or Deceptive Projects
    "Spam, fake engagement, or deceptive marketing projects",

    // Work Hours Preference
    "Not interested in full-time work exceeding 35 hours per week"
  ];

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final textColor = Theme.of(context).extension<AppTheme>()!.primaryText;

    const divider = SliverToBoxAdapter(child: Divider(height: 56));

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(child: SizedBox(height: 56)),
          TitleView.large(
            title: "Project connection",
            isSliver: true,
          ),
          HomeItemSliverBuilder(
            title: "TL;DR",
            children: [
              Text(
                tldr,
                style: textTheme.bodyLarge?.copyWith(color: textColor),
              ),
            ],
          ),
          divider,
          HomeItemSliverBuilder(
            title: "My Work Philosophy: Values and Limitations",
            children: [
              for (final d in thingsIDontWorkWith)
eff.BulletItemView(
  child: Text(
    d,
    style: textTheme.bodyLarge?.copyWith(color: textColor),
  ),
)
            ],
          ),
          divider,
        ],
      ),
    );
  }
}
