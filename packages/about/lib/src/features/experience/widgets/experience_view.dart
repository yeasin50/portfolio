import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:my_utils/my_utils.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../about.dart';
import '../../common/utils/date_format.dart';

class ExperienceView extends StatelessWidget {
  const ExperienceView({
    super.key,
    required this.experiences,
  });

  final List<Experience> experiences;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Experience',
          style: theme.textTheme.headlineSmall,
        ),
        8.verticalSpacer,
        ...experiences
            .map(
              (experience) => Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: ExperienceItemBuilder(experience: experience),
              ),
            )
            .toList(),
      ],
    );
  }
}

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
            recognizer: TapGestureRecognizer()..onTap = () => _tryToLaunch(companyUrl),
          ),
        ),
        Text(experience.title),
        if (experience.description != null) Text(experience.description!),
        Text(experienceDateFormat(experience.start, experience.end)),
      ],
    );
  }

  _tryToLaunch(String? companyUrl) async {
    if (companyUrl == null) return;

    final uri = Uri.parse(companyUrl);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }
}
