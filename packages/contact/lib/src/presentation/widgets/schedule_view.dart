import 'package:contact/src/presentation/contact_form_page.dart';
import 'package:flutter/material.dart';

import 'package:core/core.dart' as core;

import 'package:effects/effects.dart' as eff;

import '../../../contact.dart';
import '../../infrastructure/schedule_info.dart';

///  represent simple view for  [Schedules]
///
/// if time-slot is empty, it gonna highlight available_from
/// else a expandable list
///
///TODO:  add timeSlot
class ScheduleView extends StatelessWidget {
  const ScheduleView({super.key, required this.schedules});
  final Schedules? schedules;

  @override
  Widget build(BuildContext context) {
    if (schedules == null || schedules!.state == ScheduleState.hide) {
      return const SizedBox.shrink();
    }
    final theme = Theme.of(context).extension<ContactThemeExt>()!;

    final availableStr = schedules?.availableFrom == null
        ? "Get in touch..."
        : "Available from ${core.PortfolioDateFormat.basic(schedules!.availableFrom!)}";

    return Align(
      alignment: Alignment.centerLeft,
      child: SizedBox(
        width: 220,
        child: eff.TextRevealWithArrow(
          onTap: () {
            final route = ContactFormPage.route(
              animateTO: FractionalOffset(0, 0),
              plasmaData: eff.SpherePlasmaData.BJF,
            );
            Navigator.of(context).push(route);
          },
          label: availableStr,
          primaryTextStyle: theme.tldr.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
          hoverTextStyle: theme.tldr.copyWith(
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      //
    );
  }
}
