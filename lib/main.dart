import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mdntls/util/router.dart';
import 'package:mdntls/view/onboarding/onboarding_screen.dart';
import '/util/responsive_constants.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:responsive_framework/utils/scroll_behavior.dart';
import '/util/color_util.dart';
import 'dependency_injection/setup.dart';

void main() {
  setup();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
      home: OnboardingScreen(),
      //home: TutorialPage(),
    );
  }
}
