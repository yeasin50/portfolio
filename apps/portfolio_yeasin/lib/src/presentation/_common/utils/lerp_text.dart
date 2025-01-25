///  switch  between two text
///  ```dart
///  lerpText(endString, endString, t),
/// ```
String lerpText(String start, String end, double progress) {
  final int maxLength = start.length > end.length ? start.length : end.length;
  final StringBuffer result = StringBuffer();

  for (int i = 0; i < maxLength; i++) {
    if (i < (start.length * (1.0 - progress)).round() && i < start.length) {
      result.write(start[i]);
    } else if (i >= (start.length * (1.0 - progress)).round() &&
        i < end.length) {
      result.write(end[i]);
    } else {
      result.write(' ');
    }
  }

  return result.toString();
}
