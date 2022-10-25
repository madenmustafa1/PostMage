// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:mdntls/util/app_user.dart';
import '/widgets/appbar/basic_appbar.dart';
import '/widgets/appbar/drawer_menu.dart';
import '/widgets/list/user_post_list_widget.dart';
import '/util/router.dart';
import '/util/app_util.dart';
import '/util/color_util.dart';
import '/widgets/widget_util/calc_sized_box.dart';
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
      appBar: BasicAppBar(title: constants.homePageTitle),
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
}
