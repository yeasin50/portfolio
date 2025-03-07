import 'package:flutter/material.dart';

import 'package:core/core.dart' as core;

import 'package:effects/effects.dart' as eff;

import '../../../contact.dart';
import '../../infrastructure/schedule_info.dart';

///  represent simple view for  [Schedules]
///
/// if timeSlot is empty, it gonna highLight available_from
/// else a expandable list
///
class ScheduleView extends StatelessWidget {
  const ScheduleView({
    super.key,
    required this.schedules,
  });
  final Schedules schedules;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<ContactThemeExt>()!;

    final availableDate =
        core.PortfolioDateFormat.basic(schedules.availableFrom);

    ///  todo:
    if (schedules.timeSlots.isEmpty) {
      return Text(
        "Available from $availableDate",
        style: theme.tldr,
      );
    }
    return eff.FilterChip(
      label: "${schedules.availableFrom}",
      activeColor: theme.expandIconColor,
      isActive: false,
      inActiveColor: Colors.transparent,
    );
  }
}
