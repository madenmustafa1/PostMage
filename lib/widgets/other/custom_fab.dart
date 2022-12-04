import 'package:flutter/material.dart';

import '../../util/color_util.dart';
import '../../util/router.dart';
import '../widget_util/calc_sized_box.dart';

class CustomFab {
  static Widget homeOrProfileFab(
    BuildContext context,
    IconData iconData,
    VoidCallback callback,
  ) {
    return FloatingActionButton(
      child: Icon(iconData),
      onPressed: () => callback(),
      backgroundColor: ColorUtil.MAIN_COLOR,
    );
  }

  static Widget allGroupsFab(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        FloatingActionButton(
          heroTag: "tag-1",
          onPressed: () => Navigator.pushNamed(context, CRouter.GROUP_LIST),
          child: const Icon(Icons.groups),
          backgroundColor: ColorUtil.MAIN_COLOR,
        ),
        const CalcSizedBox(calc: 100),
        FloatingActionButton(
          heroTag: "tag-2",
          onPressed: () => Navigator.pushNamed(context, CRouter.CREATE_GROUP),
          child: const Icon(Icons.group_add),
          backgroundColor: ColorUtil.MAIN_COLOR,
        ),
      ],
    );
  }

  static Widget groupInfoFab(
    BuildContext context,
    VoidCallback addCallback,
    VoidCallback personCallback,
  ) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        FloatingActionButton(
          heroTag: "tag-1",
          onPressed: () => addCallback(),
          child: const Icon(Icons.add),
          backgroundColor: ColorUtil.MAIN_COLOR,
        ),
        const CalcSizedBox(calc: 100),
        FloatingActionButton(
          heroTag: "tag-2",
          onPressed: () =>personCallback(),
          child: const Icon(Icons.person_add),
          backgroundColor: ColorUtil.MAIN_COLOR,
        ),
      ],
    );
  }
}
