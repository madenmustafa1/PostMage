import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class IconsUtil {
  static Icon likeIcon({
    double? size,
  }) {
    return Icon(
      LineIcons.heartAlt,
      size: size,
    );
  }

  static Icon commentIcon({
    double? size,
  }) {
    return Icon(
      Icons.chat_bubble,
      size: size,
    );
  }
}
