import 'package:flutter/material.dart';

import '../education_info.dart';
import 'education_item_builder.dart';

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
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 16,
      children: [
        ...educations.map(
          (e) => EducationItemBuilder(education: e),
        ),
      ],
    );
  }
}
