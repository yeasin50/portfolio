import 'package:flutter/material.dart';

import '../../experience.dart';

class CertificateListView extends StatefulWidget {
  const CertificateListView({
    super.key,
    required this.certificates,
  });
  final List<Certificate> certificates;

  @override
  State<CertificateListView> createState() => _CertificateListViewState();
}

class _CertificateListViewState extends State<CertificateListView> {
  late List previewItems = widget.certificates.length > 5
      ? widget.certificates.sublist(0, 5)
      : widget.certificates;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<ExperienceTheme>()!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 16,
      children: [
        //todo:handle maxItem then add showMore
        ...previewItems.map(
          (e) => CertificateItemBuilder(certificate: e),
        ),

        if (widget.certificates.length > 5)
          Align(
            alignment: Alignment.centerLeft,
            child: Transform.translate(
              offset: const Offset(-12, 0),
              child: TextButton(
                onPressed: () {
                  setState(() {
                    previewItems =
                        previewItems.length == widget.certificates.length
                            ? widget.certificates.sublist(0, 5)
                            : widget.certificates;
                  });
                },
                child: Text(
                  previewItems.length == widget.certificates.length
                      ? 'Show less'
                      : 'Show more',
                  textAlign: TextAlign.start,
                  style: theme.descriptionStyle,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
