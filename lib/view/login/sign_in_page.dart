// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import '/dependency_injection/setup.dart';
import '/model/login/login_model.dart';
import '/util/app_util.dart';
import '/util/color_util.dart';
import '/util/constants.dart';
import '/util/router.dart';
import '../../widgets/widget_util/calc_sized_box.dart';
import '../../widgets/widget_util/show_toast.dart';
import '/widgets/text_and_button/custom_rich_text.dart';
import '/widgets/text_and_button/rich_text_field.dart';
import '/widgets/text_and_button/simple_button.dart';
import '/widgets/text_and_button/simple_text.dart';
import 'login_viewmodel.dart';

class SignInPage extends StatelessWidget {
  SignInPage({Key? key}) : super(key: key);

  TextEditingController mailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController reasswordController = TextEditingController();

  Constants constants = getIt<Constants>();
  LoginViewModel loginViewModel = getIt<LoginViewModel>();

  @override
  Widget build(BuildContext context) {
    //goToHomePage(context);

    return Scaffold(
      backgroundColor: ColorUtil.MAIN_COLOR,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //App Name
              Padding(
                padding: EdgeInsets.only(
                  bottom: AppUtil.getHeight(context) / 14,
                ),
                child: SimpleText(
                  text: constants.appName,
                  textColor: ColorUtil.WHITE,
                ),
              ),
              //E-mail
              RichTextField(
                controller: usernameController,
                hintText: constants.emailInputHintText,
              ),
              //Password
              RichTextField(
                controller: passwordController,
                hintText: constants.passwordInputHintText,
                hideText: true,
              ),
              const CalcSizedBox(calc: 100),
              //Login Button
              SimpleButton(
                buttonText: getIt<Constants>().loginButtonText,
                onPressed: () {
                  login(context);
                },
                buttonBackgroundColor: ColorUtil.WHITE,
                textColor: ColorUtil.MAIN_COLOR,
              ),
              const CalcSizedBox(calc: 80),

              CustomRichText(
                firstText: constants.signInText1,
                secondText: constants.signInText2,
                secondTextColor: ColorUtil.WHITE,
                firstOptionalTextSize: 16,
                secondOptionalTextSize: 16,
                firstTextIsBold: true,
                secondTextIsBold: true,
                onPressed: () {
                  Navigator.pushNamed(context, CRouter.SIGN_UP);
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  void login(BuildContext context) async {
    String username = usernameController.text;
    String password = passwordController.text;

    LoginModel result = await loginViewModel.signIn(username, password);

    debugPrint(result.isSucces.toString());

    if (result.isSucces) {
      Navigator.pushNamedAndRemoveUntil(
          context, CRouter.HOME, (route) => false);
    } else {
      ShowToast.errorToast(result.message ?? "QQQQ");
    }
  }
}
