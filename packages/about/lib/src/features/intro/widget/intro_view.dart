import '../../../../about.dart';
import 'package:flutter/material.dart';
import 'package:my_utils/my_utils.dart';

class IntroView extends StatelessWidget {
  const IntroView({
    super.key,
    required this.name,
    required this.description,
  });

  final Name name;
  final Description description;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name.toString(),
          style: theme.textTheme.headlineLarge,
        ),
        8.verticalSpacer,
        Text(
          description.title,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        8.verticalSpacer,
        Text(
          description.description,
          style: theme.textTheme.bodyMedium,
        ),
      ],
    );
  }
}
