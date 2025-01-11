library education;

import 'package:flutter/material.dart';

import 'education.dart';

export 'src/education_info.dart';
export 'src/widgets/widgets.dart';

extension EducationViewExt on Education {
  Widget view(Key? key) => EducationItemBuilder(
        key: key,
        education: this,
      );
}
