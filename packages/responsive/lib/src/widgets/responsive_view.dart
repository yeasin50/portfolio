part of responsive;

/// A widget that returns a different widget based on the screen size.
class ResponsiveView extends StatelessWidget {
  static late bool isMobile;
  static late bool isTablet;
  static late bool isDesktop;

  const ResponsiveView({
    super.key,
    required this.mobile,
    required this.tablet,
    required this.desktop,
  });

  final Widget mobile;
  final Widget tablet;
  final Widget desktop;

  void _assignBool({
    bool isMobile = false,
    bool isTablet = false,
    bool isDesktop = false,
  }) {
    ResponsiveView.isMobile = isMobile;
    ResponsiveView.isTablet = isTablet;
    ResponsiveView.isDesktop = isDesktop;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      // If our width is more than 1100 then we consider it a desktop
      builder: (context, constraints) {
        if (constraints.maxWidth >= 1100) {
          _assignBool(isDesktop: true);
          return desktop;
        }
        // If width it less then 1100 and more then 650 we consider it as tablet
        else if (constraints.maxWidth >= 650) {
          _assignBool(isTablet: true);
          return tablet;
        }
        // Or less then that we called it mobile
        else {
          _assignBool(isMobile: true);
          return mobile;
        }
      },
    );
  }
}
