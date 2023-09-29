import '../../../../about.dart';
import '../models/description.dart';
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
      children: [
        Text(
          name.toString(),
          style: theme.textTheme.headlineMedium,
        ),
        16.verticalSpacer,
        Text(
          description.title,
          style: theme.textTheme.titleMedium,
        ),
        16.verticalSpacer,
        Text(
          description.description,
        ),
      ],
    );
  }
}
