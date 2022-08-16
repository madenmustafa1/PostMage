// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import '/widgets/text_and_button/phone_number_text_field.dart';
import '/widgets/show_toast.dart';
import '/util/router.dart';
import '/model/login/sign_up_model.dart';
import '/dependency_injection/setup.dart';
import '/model/login/login_model.dart';
import '/util/app_util.dart';
import '/util/color_util.dart';
import '/util/constants.dart';
import '/widgets/calc_sized_box.dart';
import '/widgets/text_and_button/custom_rich_text.dart';
import '/widgets/text_and_button/rich_text_field.dart';
import '/widgets/text_and_button/simple_button.dart';
import '/widgets/text_and_button/simple_text.dart';
import 'login_viewmodel.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({Key? key}) : super(key: key);

  TextEditingController mailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController rePasswordController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  Constants constants = getIt<Constants>();
  LoginViewModel loginViewModel = getIt<LoginViewModel>();

  @override
  Widget build(BuildContext context) {
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
              //Mail
              RichTextField(
                controller: mailController,
                hintText: constants.emailInputHintText,
              ),
              //Username
              RichTextField(
                controller: usernameController,
                hintText: constants.usernameInputHintText,
              ),
              //Phone Number
              PhoneNumberTextField(controller: phoneNumberController),

              //Password
              RichTextField(
                controller: passwordController,
                hintText: constants.passwordInputHintText,
                hideText: true,
              ),
              //Re-Password
              RichTextField(
                controller: rePasswordController,
                hintText: constants.rePasswordInputHintText,
                hideText: true,
              ),

              const CalcSizedBox(calc: 150),
              //Login Button
              SimpleButton(
                buttonText: constants.signUpButtonText,
                onPressed: () {
                  signUp(context);
                },
                buttonBackgroundColor: ColorUtil.WHITE,
                textColor: ColorUtil.MAIN_COLOR,
              ),
              const CalcSizedBox(calc: 80),

              CustomRichText(
                firstText: constants.signUpText1,
                secondText: constants.signUpText2,
                secondTextColor: ColorUtil.WHITE,
                firstOptionalTextSize: 16,
                secondOptionalTextSize: 16,
                firstTextIsBold: true,
                secondTextIsBold: true,
                onPressed: () {
                  //Navigator.of(context).pop();
                  Navigator.pushNamed(context, CRouter.SIGN_IN);
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  void signUp(BuildContext context) async {
    SignUpModel signUpModel = SignUpModel(
      mail: mailController.text,
      username: usernameController.text,
      password: passwordController.text,
      rePassword: rePasswordController.text,
    );

    LoginControlModel result = await loginViewModel.signUp(signUpModel);
    if (result.isSucces) {
      Navigator.pushNamedAndRemoveUntil(
          context, CRouter.HOME, (route) => false);
    } else {
      ShowToast.errorToast(result.message);
    }
  }
}
