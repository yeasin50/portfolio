import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../../experience.dart';

class EducationItemBuilder extends StatelessWidget {
  const EducationItemBuilder({
    super.key,
    required this.education,
  });

  final Education education;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<ExperienceTheme>()!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 4,
      children: [
        Text(
          education.school.name,
          style: theme.titleStyle,
        ),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(text: education.degree),
              if (education.field != null)
                TextSpan(text: ", ${education.field}")
            ],
            style: theme.organizationTextStyle,
          ),
        ),
        Text(
          PortfolioDateFormat.experience(
            education.start,
            education.end,
          ),
          style: theme.dateTextStyle,
        ),
        if (education.grade != null)
          Text(
            education.grade ?? "",
            style: theme.organizationTextStyle.copyWith(
              color: theme.titleStyle.color,
              fontWeight: FontWeight.w500,
            ),
          ),
        if (education.description != null)
          Text(
            education.description ?? "",
            style: theme.descriptionStyle,
          ),
      ],
    );
  }
}
