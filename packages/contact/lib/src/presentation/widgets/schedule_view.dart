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
///TODO:  add timeSlot
class ScheduleView extends StatelessWidget {
  const ScheduleView({
    super.key,
    required this.schedules,
  });
  final Schedules? schedules;

  @override
  Widget build(BuildContext context) {
    if (schedules == null || schedules!.state == ScheduleState.hide) {
      return const SizedBox.shrink();
    }
    final theme = Theme.of(context).extension<ContactThemeExt>()!;

    final availableStr = schedules?.availableFrom == null
        ? "Available..."
        : "Available from ${core.PortfolioDateFormat.basic(schedules!.availableFrom!)}";

    ///  todo:
    final dateView = eff.AnimatedArrowView(
      child: DefaultTextStyle(
        style: theme.tldr.copyWith(color: Colors.black), //FIXME:
        child: Text(availableStr),
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: dateView,
        ),
      ],
    );
  }
}
