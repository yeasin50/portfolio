import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../../experience.dart';
import 'experience_list_delegate.dart';

///  show `initialMaxPreview` [experiences]
/// can be expand to show all. not so useful on web but plan for future
///
class ExperienceView extends StatefulWidget {
  const ExperienceView({
    super.key,
    required this.experiences,
    this.initialMaxPreview = 3,
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
    final theme = Theme.of(context).extension<ExperienceTheme>()!;
    return Flow(
      delegate: const ExperienceListDelegate(),
      children: [
        ...previewItems.map(
          (experience) => ExperienceItemBuilder(
            experience: experience,
          ),
        ),
        if (widget.experiences.length > widget.initialMaxPreview)
          TextButton(
            onPressed: () {
              previewItems = previewItems.length == widget.initialMaxPreview
                  ? widget.experiences
                  : widget.experiences.sublist(0, widget.initialMaxPreview);
              setState(() {});
            },
            child: Text(
              previewItems.length == widget.experiences.length
                  ? 'Show less'
                  : 'Show more',
              style: theme.descriptionStyle,
            ),
          ),
      ],
    );
  }
}
