import 'package:flutter/material.dart';
import '/util/color_util.dart';

class BoxDecorationWidgetUtil {
  static BoxDecoration borderRadius({required double borderRadius}) {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(borderRadius),
      color: ColorUtil.MAIN_COLOR,
      /*
      boxShadow: [
        BoxShadow(color: ColorUtil.MAIN_COLOR, spreadRadius: 15),
      ],
      */
    );
  }
}
