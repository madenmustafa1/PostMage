import 'package:flutter/material.dart';

import '../util/color_util.dart';

class BasicAppBar extends StatelessWidget with PreferredSizeWidget {
  final String title;
  BasicAppBar({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: ColorUtil.MAIN_COLOR,
      title: Text(title),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
