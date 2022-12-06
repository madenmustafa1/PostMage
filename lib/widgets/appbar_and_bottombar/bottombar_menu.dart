import 'package:flutter/material.dart';
import '../../view/group/all_groups_post/all_groups_post_page.dart';
import '../../view/home/home_page.dart';
import '../../view/profile/profile_page.dart';

import '../../dependency_injection/setup.dart';
import '../../util/color_util.dart';
import '../../util/constants.dart';

class BottombarMenu {
  static final List<Widget> widgetOptions = <Widget>[
    HomePage(),
    AllGroupsPostPage(),
    ProfilePage()
  ];

  final Constants _constants = getIt<Constants>();

  Widget bottomNavigationBar(int _selectedIndex, Function(int) callback) {
    return BottomNavigationBar(
      backgroundColor: ColorUtil.MAIN_COLOR,
      items: [
        BottomNavigationBarItem(
          icon: const Icon(Icons.home),
          label: _constants.homePageTitle,
          backgroundColor: ColorUtil.MAIN_COLOR,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.group),
          label: _constants.groups,
          backgroundColor: ColorUtil.MAIN_COLOR,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.person),
          label: _constants.profilePageTitle,
          backgroundColor: ColorUtil.MAIN_COLOR,
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: ColorUtil.WHITE,
      onTap: callback,
    );
  }

  String indexToAppbarName(int index) {
    if (index == 0) return _constants.homePageTitle;
    if (index == 1) return _constants.groups;
    if (index == 2) return _constants.profilePageTitle;
    return _constants.homePageTitle;
  }
}
