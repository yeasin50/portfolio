import '../../../../about.dart';
import '../../certification/widgets/certificate_view.dart';
import '../provider/about_data_provider.dart';
import '../../education/widgets/education_view.dart';
import '../../experience/widgets/experience_view.dart';
import '../../intro/widget/intro_view.dart';
import 'package:flutter/material.dart';
import 'package:my_utils/my_utils.dart';

import '../../intro/widget/image_builder.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({
    super.key,
    required this.data,
  });

  final AboutPageData data;

  @override
  Widget build(BuildContext context) {
    ///! remove on release, this will be called in mainApp

    return AboutDataProvider(
      data: data,
      child: Scaffold(),
    );
  }
}
