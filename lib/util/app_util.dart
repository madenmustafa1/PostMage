import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppUtil {
  static double getWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;
  static double getHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;

  static systemStatusBarChangeColor() {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark,
        systemNavigationBarDividerColor: null,
        systemNavigationBarColor: Color(0xFF000000),
      ),
    );
  }
}
