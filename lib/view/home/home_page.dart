// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import '/util/router.dart';
import '/widgets/appbar_border_radius.dart';
import '/widgets/text_and_button/rich_text_field.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import '/view/home/home_page_list.dart';
import '/view/home/home_page_user_title.dart';
import '/widgets/text_and_button/simple_button.dart';
import '/util/app_util.dart';
import '/util/color_util.dart';
import '/widgets/calc_sized_box.dart';
import '/widgets/text_and_button/simple_text.dart';
import '/dependency_injection/setup.dart';
import '/util/constants.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  Constants constants = getIt<Constants>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ColorUtil.GREY_PLATINUM,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, CRouter.ADD_POST);
        },
        backgroundColor: ColorUtil.MAIN_COLOR,
      ),
      appBar: AppBar(
        //leading: Container(),
        title: SimpleText(
          text: constants.homePageTitle,
          optionalTextSize: 25,
        ),
        backgroundColor: ColorUtil.GREY_PLATINUM,
        shadowColor: null,
        shape: AppbarWidgetUtil.appbarBorderRadius(),
      ),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        key: key,
        child: SizedBox(
          width: AppUtil.getWidth(context),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CalcSizedBox(calc: 20),
              HomePageUserTitle(),
              const CalcSizedBox(calc: 15),
              //E.T.
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Stack(
                    children: [
                      SimpleButton(
                          customWidgetAligmentLeft: true,
                          buttonText: constants.firstText,
                          customRadiusLeft: true,
                          onPressed: () {}),
                    ],
                  ),
                ],
              ),
              const CalcSizedBox(calc: 60),
              //Ü
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Stack(
                    children: [
                      SimpleButton(
                          customWidgetAligmentLeft: true,
                          buttonText: constants.secondText,
                          customRadiusLeft: true,
                          onPressed: () {}),
                    ],
                  ),
                ],
              ),
              const CalcSizedBox(calc: 60),
              //C.T.

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Stack(
                    children: [
                      SimpleButton(
                        customWidgetAligmentLeft: true,
                        buttonText: constants.thirdText,
                        customRadiusLeft: true,
                        onPressed: () => showModal(context),
                      ),
                    ],
                  ),
                ],
              ),

              const CalcSizedBox(calc: 20),
              //ListView
              HomePageList()
            ],
          ),
        ),
      ),
    );
  }

  TextEditingController addressController = TextEditingController();

  void showModal(BuildContext context) {
    showMaterialModalBottomSheet(
      expand: false,
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          RichTextField(
              controller: addressController,
              hintText: "Lütfen adresinizi giriniz"),
          addPaddingWhenKeyboardAppears()
        ],
      ),
    );
  }

  SizedBox addPaddingWhenKeyboardAppears() {
    final viewInsets = EdgeInsets.fromWindowPadding(
      WidgetsBinding.instance!.window.viewInsets,
      WidgetsBinding.instance!.window.devicePixelRatio,
    );

    final bottomOffset = viewInsets.bottom + 35;
    const hiddenKeyboard = 0.0; // Always 0 if keyboard is not opened
    final isNeedPadding = bottomOffset != hiddenKeyboard;

    return SizedBox(height: isNeedPadding ? bottomOffset : hiddenKeyboard);
  }
}

// ListView(
