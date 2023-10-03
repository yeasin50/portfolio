import 'package:about/about.dart';
import 'package:about/src/features/certification/widgets/certificate_view.dart';
import 'package:about/src/features/core/models/about_data.dart';
import 'package:about/src/features/core/provider/about_data_provider.dart';
import 'package:about/src/features/education/widgets/education_view.dart';
import 'package:about/src/features/experience/widgets/experience_view.dart';
import 'package:about/src/features/intro/widget/intro_view.dart';
import 'package:flutter/material.dart';
import 'package:my_utils/my_utils.dart';
import 'package:responsive/responsive.dart';

import '../../intro/widget/image_builder.dart';

part 'about_page_web.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({
    super.key,
    required this.data,
  });

  final AboutPageData data;

  @override
  Widget build(BuildContext context) {
    ///! remove on release, this will be called in mainApp
    Responsive.init(context);

    return AboutDataProvider(
      data: data,
      child: Scaffold(
        body: ResponsiveView(
          mobile: AboutWebView(),
          tablet: AboutWebView(),
          desktop: AboutWebView(),
        ),
      ),
    );
  }
}
