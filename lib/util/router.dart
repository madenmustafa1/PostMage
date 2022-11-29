// ignore_for_file: non_constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../model/group/get_my_group_list_model.dart';
import '/view/group/all_groups_post/all_groups_post_page.dart';
import '/view/group/create_group/create_group_page.dart';
import '/view/group/group_info/group_info_page.dart';
import '/view/group/group_list/group_list_page.dart';
import '/view/add_user/add_user_page.dart';
import '/view/profile/profile_page.dart';
import '../view/qr_code/scan_qr_code_page.dart';
import '/view/add_post/add_post_page.dart';
import '/view/tutorial/tutorial_page.dart';
import '/view/login/sign_in_page.dart';
import '/view/home/home_page.dart';
import '/view/login/sign_up_page.dart';

class CRouter {
  static String SIGN_UP = '/sign_up';
  static String SIGN_IN = '/sign_in';
  static String HOME = '/home';
  static String TUTORIAL = '/tutorial';
  static String ADD_POST = '/add_post';
  static String HOME_REMOVE_UNTIL = '/home_remove_until';
  static String PROFILE = '/profile';
  static String ADD_USER = '/add_user';
  static String QR_CODE = '/qr_code';
  static String ALL_GROUPS_POST = '/all_groups_post';
  static String CREATE_GROUP = '/create_group';
  static String GROUP_LIST = '/group_list';
  static String GROUP_INFO = '/group_info';

  static Route<dynamic>? customOnGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/sign_in':
        return CupertinoPageRoute(
          builder: (_) => SignInPage(),
          settings: settings,
        );

      case '/sign_up':
        return CupertinoPageRoute(
          builder: (_) => SignUpPage(),
          settings: settings,
        );

      case '/home':
        return CupertinoPageRoute(
          builder: (_) => HomePage(),
          settings: settings,
        );
      case '/tutorial':
        return CupertinoPageRoute(
          builder: (_) => TutorialPage(),
          settings: settings,
        );

      case '/add_post':
        return CupertinoPageRoute(
          builder: (_) => const AddPostPage(),
          settings: settings,
          fullscreenDialog: true,
        );

      case '/profile':
        return CupertinoPageRoute(
          builder: (_) => ProfilePage(),
          settings: settings,
        );

      case '/add_user':
        return CupertinoPageRoute(
          builder: (_) => const AddUserPage(),
          settings: settings,
          fullscreenDialog: true,
        );

      case '/qr_code':
        return CupertinoPageRoute(
          builder: (_) => const ScanQRCodePage(),
          settings: settings,
        );

      case "/all_groups_post":
        return CupertinoPageRoute(
          builder: (_) => AllGroupsPostPage(),
          settings: settings,
        );

      case "/create_group":
        return CupertinoPageRoute(
          builder: (_) => CreateGroupPage(),
          settings: settings,
        );

      case "/group_list":
        return CupertinoPageRoute(
          builder: (_) => const GroupListPage(),
          settings: settings,
        );

      case "/group_info":
        if (settings.arguments is GetMyGroupListModel) {
          // the details page for one specific user
          return MaterialPageRoute(
            builder: (_) =>
                GroupInfoPage(model: settings.arguments as GetMyGroupListModel),
            settings: settings,
            fullscreenDialog: true,
          );
        }
    }
    return null;
  }
}
