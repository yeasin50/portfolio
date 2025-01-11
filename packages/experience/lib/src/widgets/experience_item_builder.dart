import 'package:core/core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../experience_.dart';

class ExperienceItemBuilder extends StatelessWidget {
  const ExperienceItemBuilder({
    super.key,
    required this.experience,
  });
  final Experience experience;

  @override
  Widget build(BuildContext context) {
    final companyUrl = experience.company.websiteUrl;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(
            text: experience.company.name,
            style: Theme.of(context).textTheme.titleMedium,
            recognizer: TapGestureRecognizer()
              ..onTap = () => _tryToLaunch(companyUrl),
          ),
        ),
        Text(experience.title),
        if (experience.description != null) Text(experience.description!),
        Text(PortfolioDateFormat.experience(experience.start, experience.end)),
      ],
    );
  }

  _tryToLaunch(String? companyUrl) async {}
}
