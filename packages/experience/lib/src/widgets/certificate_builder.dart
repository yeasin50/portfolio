import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../../experience.dart';

class CertificateItemBuilder extends StatelessWidget {
  const CertificateItemBuilder({
    super.key,
    required this.certificate,
  });
  final Certificate certificate;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<ExperienceTheme>()!;
    bool hasCredentialUrl = certificate.credentialUrl != null;

    //!remove or find purpose on release
    // var toolRichMessage = TextSpan(
    //   style: theme.textTheme.bodyMedium,
    //   children: [
    //     if (widget.certificate.issueDate != null)
    //       TextSpan(
    //         text:
    //             "issued on ${PortfolioDateFormat.certificate(widget.certificate.issueDate!)}",
    //       ),
    //     if (widget.certificate.expirationDate != null)
    //       TextSpan(
    //         text:
    //             " and expired on ${PortfolioDateFormat.certificate(widget.certificate.expirationDate!)}",
    //       ),
    //     if (widget.certificate.credentialUrl != null)
    //       TextSpan(
    //         text: "\n View credential ${widget.certificate.credentialUrl}",
    //       ),
    //   ],
    // );

    return InkWell(
      onTap: hasCredentialUrl ? () async {} : null,
      onHover: (value) {},
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        spacing: 1,
        children: [
          Text(
            certificate.name,
            style: theme.titleStyle,
          ),
          Text(
            certificate.organization.name,
            style: theme.organizationTextStyle,
          ),
          if (certificate.issueDate != null)
            Text(
              PortfolioDateFormat.certificate(
                certificate.issueDate!,
                certificate.expirationDate,
              ),
              style: theme.dateTextStyle,
            ),
          if (certificate.description != null)
            Text(
              certificate.description!,
              style: theme.descriptionStyle,
            ),
        ],
      ),
    );
  }
}
