import 'package:flutter/material.dart';

class WidgetUtil {
  Decoration? boxDecoration({
    bool? left,
    bool? right,
    bool? bottom,
    bool? top,
    Color? color,
    double? widht,
  }) {
    return BoxDecoration(
      border: Border(
        bottom: returnBorderSide(widht, color, bottom),
        top: returnBorderSide(widht, color, top),
        left: returnBorderSide(widht, color, left),
        right: returnBorderSide(widht, color, right),
      ),
    );
  }

  BorderSide returnBorderSide(double? widht, Color? color, bool? showBorder) {
    if (showBorder == null) {
      return BorderSide.none;
    }
    return BorderSide(
      width: widht ?? 1,
      color: color ?? Colors.grey,
    );
  }

  Padding returnPadding({
    required Widget widget,
    double? top,
    double? bottom,
    double? left,
    double? right,
  }) {
    return Padding(
      padding: EdgeInsets.only(
        top: top ?? 0,
        bottom: bottom ?? 0,
        left: left ?? 0,
        right: right ?? 0,
      ),
      //padding:  EdgeInsets.symmetric(horizontal: padding ?? 20),
      child: widget,
    );
  }
}
