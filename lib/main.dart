import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mdntls/view/main_activity/main_activity.dart';
import '/model/login/login_model.dart';
import '/util/app_user.dart';
import '/view/home/home_page.dart';
import '/util/router.dart';
import '/view/onboarding/onboarding_screen.dart';
import '/util/responsive_constants.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:responsive_framework/utils/scroll_behavior.dart';
import '/util/color_util.dart';
import 'dependency_injection/setup.dart';
import 'util/shared_preferences.dart';

void main() {
  setup();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light),
  );

  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final SharedPreferencesUtil preferencesUtil = getIt<SharedPreferencesUtil>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: CRouter.customOnGenerateRoute,
      builder: (context, widget) => ResponsiveWrapper.builder(
        BouncingScrollWrapper.builder(context, widget!),
        maxWidth: 1200,
        minWidth: 450,
        defaultScale: true,
        backgroundColor: ColorUtil.BACKGROUND_COLOR,
        breakpoints: ResponsiveConstants.BREAKPOINTS,
        background: Container(color: ColorUtil.BACKGROUND_COLOR),
      ),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder(
        future: authControl(),
        builder: (BuildContext context, AsyncSnapshot<bool> value) {
          if (value.data == null) {
            return const Scaffold(
              body: CircularProgressIndicator(),
            );
          }
          if (!value.data!) return OnboardingScreen();
          return MainActivity();
        },
      ),
    );
  }

  Future<bool> authControl() async {
    await preferencesUtil.initPrefs();
    String? token = preferencesUtil.getString(preferencesUtil.TOKEN);
    String? userId = preferencesUtil.getString(preferencesUtil.USER_ID);

    if (token == null || token == "") return false;
    AppUser.LOGIN_TOKEN_MODEL = LoginTokenModel(
      token: token,
      userId: userId,
      isSuccess: true,
    );
    return true;
  }
}
