import 'package:flutter/material.dart';

/// show the
class RoutineView extends StatefulWidget {
  const RoutineView({
    super.key,
    required this.title,
    required this.headers,
    required this.entity,
  });

  final String title;
  final List<String> headers;
  final List<List<String>> entity;

  @override
  State<RoutineView> createState() => _RoutineViewState();
}

class _RoutineViewState extends State<RoutineView> {
  @override
  Widget build(BuildContext context) {
    assert(() {
      if (widget.entity.any((r) => r.length != widget.headers.length)) {
        return false;
      }
      return true;
    }(), "headers length should match with entity rows");

    final style = TextStyle(fontSize: 16, color: Colors.white);
    return IntrinsicWidth(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 16,
        children: [
          Text(widget.title, style: style),
          Material(
            color: Colors.white.withAlpha(100),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 8,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                spacing: 8,
                children: [
                  RowBuilder(data: widget.headers, isHeader: true), //
                  Divider(),
                  for (final e in widget.entity)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 0.0),
                      child: RowBuilder(data: e),
                    ), //
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RowBuilder extends StatelessWidget {
  const RowBuilder({super.key, required this.data, this.isHeader = false});
  final List<String> data;
  final bool isHeader;

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.bodyMedium?.copyWith(
      color: Colors.white,
      fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
    );
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.min,
      spacing: 32,
      children: [
        for (int i = 0; i < data.length; i++)
          Expanded(
            child: Align(
              alignment: Alignment(i==0? -1 : i==data.length-1? 0: 0, 0),
              child: Text(data[i], style: style),
            ),
          ), //
      ],
    );
  }
}
