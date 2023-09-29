import 'package:flutter/material.dart';

import '../../../../about.dart';
import '../../common/utils/date_format.dart';
import '../../common/widgets/link_textview.dart';

class CertificateView extends StatelessWidget {
  const CertificateView({
    super.key,
    required this.certificates,
  });
  final List<Certificate> certificates;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Certificate',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 8),
        ...certificates.map((e) => CertificateItemBuilder(certificate: e)),
      ],
    );
  }
}

class CertificateItemBuilder extends StatelessWidget {
  const CertificateItemBuilder({
    super.key,
    required this.certificate,
  });
  final Certificate certificate;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(certificate.name),
        Text(certificate.organization.name),
        if (certificate.issueDate != null) Text(certificateDateFormat(certificate.issueDate!, null)),
        if (certificate.credentialUrl != null || certificate.imageUrl != null)
          LinkTextView(
            paragraph: "View Credential",
            url: certificate.credentialUrl ?? certificate.imageUrl!,
          ),
        if (certificate.description != null)
          Text(
            certificate.description!,
          ),
      ],
    );
  }
}
