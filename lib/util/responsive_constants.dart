import 'package:responsive_framework/responsive_framework.dart';

class ResponsiveConstants {
  // ignore: non_constant_identifier_names
  static List<ResponsiveBreakpoint>? BREAKPOINTS = [
    const ResponsiveBreakpoint.resize(450, name: MOBILE),
    const ResponsiveBreakpoint.autoScale(800, name: TABLET),
    const ResponsiveBreakpoint.autoScale(1000, name: TABLET),
    const ResponsiveBreakpoint.resize(1200, name: DESKTOP),
    const ResponsiveBreakpoint.autoScale(2460, name: "4K"),
  ];
}
