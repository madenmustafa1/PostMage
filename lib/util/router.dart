// ignore_for_file: non_constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:mdntls/view/profile/profile_page.dart';
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
          builder: (_) => const ProfilePage(),
          settings: settings,

        );
    }
    return null;
  }
}
