import 'package:flutter/material.dart';

import '/util/color_util.dart';
import '../text_and_button/simple_text.dart';
import '../widget_util/appbar_border_radius.dart';

class BasicAppBar extends StatelessWidget with PreferredSizeWidget {
  final String title;
  BasicAppBar({
    Key? key,
    required this.title,
    this.shapeDisabled
  }) : super(key: key);

  final bool? shapeDisabled;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: SimpleText(
        text: title,
        optionalTextSize: 25,
        textColor: ColorUtil.WHITE,
      ),
      backgroundColor: ColorUtil.MAIN_COLOR,
      shadowColor: null,
      shape: shapeDisabled == null ? AppbarWidgetUtil.appbarBorderRadius() : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
