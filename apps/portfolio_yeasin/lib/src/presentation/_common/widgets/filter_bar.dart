import 'package:flutter/material.dart';

import 'package:effects/effects.dart' as eff;

import '../../../app/app.dart';

/// filter options from  [items] and [onChanged] returns selected items.
///
/// - [onChanged]  returns the selected strings
///
/// - [initialSelected]
///
class FilterBar extends StatefulWidget {
  const FilterBar({
    super.key,
    required this.items,
    required this.onChanged,
    required this.initialSelected,
  });

  final List<String> items;
  final ValueChanged<List<String>> onChanged;
  final List<String> initialSelected;

  @override
  State<FilterBar> createState() => _FilterBarState();
}

class _FilterBarState extends State<FilterBar> {
  late List<String> selected = [...widget.initialSelected];

  void onTap(String e) {
    selected.contains(e) //
        ? selected.remove(e)
        : selected.add(e);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<ConnectThemeExt>()!;
    //
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: widget.items.map(
        (e) {
          final labelStyle = theme.hintTextStyle;
          return eff.FilterChip(
            label: e,
            isActive: selected.contains(e),
            activeColor: theme.hoverColor,
            inActiveColor: theme.background,
            labelStyle: labelStyle,
            onTap: () => onTap(e),
          );
        },
      ).toList(),
    );
  }
}
