import 'package:flutter/material.dart';

import '/util/app_util.dart';

BoxConstraints boxConstraintsList(BuildContext context) {
  return BoxConstraints(
    minWidth: AppUtil.getWidth(context) / 2,
    maxWidth: AppUtil.getWidth(context) / 1.1,
    minHeight: AppUtil.getHeight(context) / 8.5,
    maxHeight: AppUtil.getHeight(context) / 1.9,
  );
}
