// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import '/view/tutorial/tutorial_top_widget.dart';
import '/widgets/calc_sized_box.dart';
import '/widgets/text_and_button/simple_button.dart';
import '/util/router.dart';
import '/util/color_util.dart';
import '/dependency_injection/setup.dart';
import '/util/app_util.dart';
import '/util/constants.dart';
import '/widgets/text_and_button/simple_text.dart';

class TutorialPage extends StatelessWidget {
  TutorialPage({Key? key}) : super(key: key);

  Constants constants = getIt<Constants>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: BasicAppBar(title: constants.appName),
      body: SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TutorialTopWidget(),
              const CalcSizedBox(calc: 15),
              Padding(
                padding: EdgeInsets.only(
                  bottom: AppUtil.getHeight(context) / 30,
                ),
                child: SimpleText(
                  text: constants.tutorialTitle,
                  optionalTextSize: AppUtil.getHeight(context) / 30,
                  textColor: ColorUtil.MAIN_COLOR,
                ),
              ),
              const CalcSizedBox(calc: 15),
              SimpleButton(
                buttonText: constants.tutorialSignUpButtonText,
                onPressed: () {
                  Navigator.pushNamed(context, CRouter.SIGN_UP);
                },
              ),
              const CalcSizedBox(calc: 50),
              SimpleButton(
                buttonText: constants.tutorialSigInButtonText,
                onPressed: () {
                  Navigator.pushNamed(context, CRouter.SIGN_IN);
                },
                buttonBackgroundColor: ColorUtil.WHITE,
                textColor: ColorUtil.MAIN_COLOR,
              )
            ]),
      ),
    );
  }
}
