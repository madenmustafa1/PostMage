// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import '/widgets/menu/drawer_menu.dart';
import '../../widgets/list/user_post_list_widget.dart';
import '/util/router.dart';
import '../../widgets/widget_util/appbar_border_radius.dart';
import '/widgets/text_and_button/rich_text_field.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import '/util/app_util.dart';
import '/util/color_util.dart';
import '../../widgets/widget_util/calc_sized_box.dart';
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
      drawer: customDrawerMenu(context),
      appBar: AppBar(
        //leading: Container(),
        title: SimpleText(
          text: constants.homePageTitle,
          optionalTextSize: 25,
          textColor: ColorUtil.WHITE,
        ),

        backgroundColor: ColorUtil.MAIN_COLOR,
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
              const CalcSizedBox(calc: 65),
              UserPostListWidget(),
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
            hintText: "Lütfen adresinizi giriniz",
          ),
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
