import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:my_utils/my_utils.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../about.dart';
import '../../common/utils/date_format.dart';

class ExperienceView extends StatefulWidget {
  const ExperienceView({
    super.key,
    required this.experiences,
  });

  final List<Experience> experiences;

  @override
  State<ExperienceView> createState() => _ExperienceViewState();
}

class _ExperienceViewState extends State<ExperienceView> {
  late List previewItems = widget.experiences.length > 5 ? widget.experiences.sublist(0, 5) : widget.experiences;
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
        ...previewItems
            .map(
              (experience) => Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: ExperienceItemBuilder(experience: experience),
              ),
            )
            .toList(),
        if (widget.experiences.length > 5)
          TextButton(
            onPressed: () {
              setState(() {
                previewItems = previewItems.length == widget.experiences.length ? widget.experiences.sublist(0, 5) : widget.experiences;
              });
            },
            child: Text(
              previewItems.length == widget.experiences.length ? 'Show less' : 'Show more',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: Colors.blueAccent,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
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
