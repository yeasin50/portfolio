import 'package:core/core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../experience.dart';

class ExperienceItemBuilder extends StatelessWidget {
  const ExperienceItemBuilder({
    super.key,
    required this.experience,
  });
  final Experience experience;

  @override
  Widget build(BuildContext context) {
    final companyUrl = experience.company.websiteUrl;
    final theme = Theme.of(context).extension<ExperienceTheme>()!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      spacing: 1,
      children: [
        Text(
          experience.title,
          style: theme.titleStyle,
        ),
        Text.rich(
          TextSpan(
            text: experience.company.name,
            style: theme.organizationTextStyle,
            // recognizer: TapGestureRecognizer()
            //   ..onTap = () => _tryToLaunch(companyUrl),
          ),
        ),
        Text(
          PortfolioDateFormat.experience(experience.start, experience.end),
          style: theme.dateTextStyle,
        ),
        if (experience.description != null)
          Text(
            experience.description!,
            style: theme.descriptionStyle,
          ),
      ],
    );
  }

  _tryToLaunch(String? companyUrl) async {}
}
