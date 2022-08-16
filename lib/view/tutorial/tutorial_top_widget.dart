// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import '/dependency_injection/setup.dart';
import '/util/app_util.dart';
import '/util/color_util.dart';
import '/util/constants.dart';
import '/widgets/text_and_button/simple_text.dart';

class TutorialTopWidget extends StatelessWidget {
  TutorialTopWidget({Key? key}) : super(key: key);
  Constants constants = getIt<Constants>();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: ColorUtil.MAIN_COLOR,
      child: Padding(
        padding: EdgeInsets.only(
          top: AppUtil.getHeight(context) / 3,
          bottom: AppUtil.getHeight(context) / 40,
        ),
        child: Center(
          child: SimpleText(
            text: constants.appName,
            optionalTextSize: AppUtil.getHeight(context) / 18,
            textColor: ColorUtil.WHITE,
          ),
        ),
      ),
    );
  }
}
