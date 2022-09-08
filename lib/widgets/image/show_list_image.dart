import 'package:flutter/cupertino.dart';

import '/util/app_util.dart';
import '../widget_util/box_decoration.dart';

Widget showListImage({
  required BuildContext context,
  int? item,
}) {
  return Container(
    height: AppUtil.getHeight(context) / 2.8,
    width: AppUtil.getWidth(context),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: Image(
        image: AssetImage(
          "assets/test_images/" + (item! + 1).toString() + ".jpg",
        ),
        fit: BoxFit.cover,
      ),
    ),
    decoration: BoxDecorationWidgetUtil.borderRadius(
      borderRadius: 10,
    ),
  );
}
