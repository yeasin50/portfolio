
part of responsive;

const double kMobileMaxWidth = 650;
const double kTabletMaxWidth = 1100;
const double kMaxWidth = 1200.0;

enum ScreenType {
  mobile(kMobileMaxWidth),
  tablet(kTabletMaxWidth),
  desktop(kMaxWidth);

  const ScreenType(this.maxWidth);

  final double maxWidth;
}
