import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../experience_.dart';
import 'experience_item_builder.dart';

///  show `initialMaxPreview` [experiences]
/// can be expand to show all. not so useful on web but plan for future
///
class ExperienceView extends StatefulWidget {
  const ExperienceView({
    super.key,
    required this.experiences,
    this.initialMaxPreview = 5,
  });

  final List<Experience> experiences;

  final int initialMaxPreview;

  @override
  State<ExperienceView> createState() => _ExperienceViewState();
}

class _ExperienceViewState extends State<ExperienceView> {
  late final int maxItem =
      math.min(widget.initialMaxPreview, widget.experiences.length);

  late List previewItems = widget.experiences.sublist(0, maxItem);

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
        const SizedBox(height: 8),
        ...previewItems.map(
          (experience) => Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: ExperienceItemBuilder(experience: experience),
          ),
        ),
        if (widget.experiences.length > 5)
          TextButton(
            onPressed: () {
              setState(() {
                previewItems = previewItems.length == widget.experiences.length
                    ? widget.experiences.sublist(0, 5)
                    : widget.experiences;
              });
            },
            child: Text(
              previewItems.length == widget.experiences.length
                  ? 'Show less'
                  : 'Show more',
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
