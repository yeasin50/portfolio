import 'package:flutter/material.dart';

import '../education_info.dart';
import 'education_view.dart';

///  preview [educations] with just header
///
class EducationItemsView extends StatelessWidget {
  const EducationItemsView({
    super.key,
    required this.educations,
  });

  final List<Education> educations;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
