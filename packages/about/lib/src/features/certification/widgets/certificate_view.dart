import 'package:flutter/material.dart';
import 'package:my_utils/my_utils.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../about.dart';
import '../../common/utils/date_format.dart';

class CertificateView extends StatefulWidget {
  const CertificateView({
    super.key,
    required this.certificates,
  });
  final List<Certificate> certificates;

  @override
  State<CertificateView> createState() => _CertificateViewState();
}

class _CertificateViewState extends State<CertificateView> {
  late List previewItems = widget.certificates.length > 5 ? widget.certificates.sublist(0, 5) : widget.certificates;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Certificate',
          style: theme.textTheme.headlineSmall,
        ),
        const SizedBox(height: 8),
        //todo:handle maxItem then add showMore
        ...previewItems.map(
          (e) => CertificateItemBuilder(certificate: e),
        ),

        if (widget.certificates.length > 5)
          TextButton(
            onPressed: () {
              setState(() {
                previewItems = previewItems.length == widget.certificates.length ? widget.certificates.sublist(0, 5) : widget.certificates;
              });
            },
            child: Text(
              previewItems.length == widget.certificates.length ? 'Show less' : 'Show more',
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

class CertificateItemBuilder extends StatefulWidget {
  const CertificateItemBuilder({
    super.key,
    required this.certificate,
  });
  final Certificate certificate;

  @override
  State<CertificateItemBuilder> createState() => _CertificateItemBuilderState();
}

class _CertificateItemBuilderState extends State<CertificateItemBuilder> {
  bool _isHover = false;

  bool get hasCredentialUrl => widget.certificate.credentialUrl != null;
  @override
  Widget build(BuildContext context) {
    logger.i("hasCredentialUrl: $hasCredentialUrl");
    final theme = Theme.of(context);

    //!remove or find purpose on release
    var toolRichMessage = TextSpan(
      style: theme.textTheme.bodyMedium,
      children: [
        if (widget.certificate.issueDate != null)
          TextSpan(
            text: "issued on ${certificateDateFormat(widget.certificate.issueDate!)}",
          ),
        if (widget.certificate.expirationDate != null)
          TextSpan(
            text: " and expired on ${certificateDateFormat(widget.certificate.expirationDate!)}",
          ),
        if (widget.certificate.credentialUrl != null)
          TextSpan(
            text: "\n View credential ${widget.certificate.credentialUrl}",
          ),
      ],
    );

    return InkWell(
      onTap: hasCredentialUrl
          ? () async {
              final uri = Uri.parse(widget.certificate.credentialUrl!);
              if (await canLaunchUrl(uri)) {
                await launchUrl(uri);
              }
            }
          : null,
      onHover: (value) {
        _isHover = value;
        setState(() {});
      },
      child: RichText(
        text: TextSpan(
          style: theme.textTheme.bodyMedium,
          children: [
            TextSpan(
              text: widget.certificate.name,
              style: theme.textTheme.titleMedium?.copyWith(
                color: hasCredentialUrl && _isHover ? Colors.blueAccent : null,
                decoration: hasCredentialUrl && _isHover ? TextDecoration.underline : null,
              ),
            ),
            const TextSpan(text: " By "),
            TextSpan(
              text: widget.certificate.organization.name,
            ),
          ],
        ),
      ),
    );
  }
}
