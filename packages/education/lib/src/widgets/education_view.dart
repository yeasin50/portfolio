import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../education_info.dart';

class EducationItemBuilder extends StatelessWidget {
  const EducationItemBuilder({
    super.key,
    required this.education,
  });

  final Education education;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          education.school.name,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        Text(education.degree),
        if (education.field != null) Text(education.field!),
        Text(PortfolioDateFormat.experience(education.start, education.end)),
      ],
    );
  }
}
