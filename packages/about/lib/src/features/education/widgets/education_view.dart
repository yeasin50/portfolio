import 'package:flutter/material.dart';

import '../../../../about.dart';
import '../../common/utils/date_format.dart';

class EducationView extends StatelessWidget {
  const EducationView({
    super.key,
    required this.educations,
  });

  final List<Education> educations;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Education',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 8),
        ...educations.map((e) => EducationItemBuilder(education: e)),
      ],
    );
  }
}

class EducationItemBuilder extends StatelessWidget {
  const EducationItemBuilder({
    super.key,
    required this.education,
  });

  final Education education;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(education.school.name),
        Text(education.degree),
        if (education.field != null) Text(education.field!),
        Text(experienceDateFormat(education.start, education.end)),
      ],
    );
  }
}
