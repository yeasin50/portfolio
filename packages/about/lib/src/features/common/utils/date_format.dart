import 'package:intl/intl.dart';

@Deprecated("use `core` pkg `PortfolioDateFormat` instead")
String experienceDateFormat(DateTime start, DateTime? end) {
  final startString = DateFormat('MMM yyyy').format(start);
  final endString =
      end == null ? 'Present' : DateFormat('MMM yyyy').format(end);
  return '$startString - $endString';
}

@Deprecated("use `core` pkg `PortfolioDateFormat` instead")
String certificateDateFormat(DateTime start) {
  final startString = DateFormat('MMM yyyy').format(start);
  return 'Issued $startString';
}
