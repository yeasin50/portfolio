import 'package:intl/intl.dart';

class PortfolioDateFormat {
  /// (e.g., 'Jan 2025')
  static String experience(DateTime start, DateTime? end) {
    final startString = DateFormat('MMM yyyy').format(start);
    final endString =
        end == null ? 'Present' : DateFormat('MMM yyyy').format(end);
    return '$startString - $endString';
  }

  /// (e.g., 'Jan 2025')
  static String certificate(DateTime start) {
    final startString = DateFormat('MMM yyyy').format(start);
    return 'Issued $startString';
  }
}
