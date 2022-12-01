import 'package:flutter/material.dart';

class AppbarWidgetUtil {
  static RoundedRectangleBorder appbarBorderRadius() {
    return const RoundedRectangleBorder(
      //borderRadius: BorderRadius.circular(25.0),
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(25.0),
        bottomRight: Radius.circular(25.0),
      ),
    );
  }
}
