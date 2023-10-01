part of responsive;

class Responsive {
  static final Responsive _instance = Responsive._internal();
  factory Responsive() => _instance;
  Responsive._internal();

  static Size? _size;
  Size? get size => _size;

  static late double _maxMobileWidth;
  static late double _maxTabletWidth;

  Responsive.init(
    BuildContext context, {
    double maxMobileWidth = kMobileMaxWidth,
    double maxTabletWidth = kTabletMaxWidth,
  }) {
    _size = MediaQuery.sizeOf(context);
    _maxMobileWidth = maxMobileWidth;
    _maxTabletWidth = maxTabletWidth;
  }

  Responsive.initWithSize(
    Size size, {
    double maxMobileWidth = kMobileMaxWidth,
    double maxTabletWidth = kTabletMaxWidth,
  }) {
    _size = size;
    _maxMobileWidth = maxMobileWidth;
    _maxTabletWidth = maxTabletWidth;
  }

  static ScreenType get screenType {
    assert(_size != null, () {
      return 'Responsive not initialized. Please call Responsive.init(context) or Responsive.initWithSize(size)';
    });
    final width = _size!.width;
    if (width > _maxTabletWidth) {
      return ScreenType.desktop;
    } else if (width > _maxMobileWidth) {
      return ScreenType.tablet;
    } else {
      return ScreenType.mobile;
    }
  }
}
