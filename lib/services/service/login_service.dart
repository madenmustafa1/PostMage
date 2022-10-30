// ignore_for_file: non_constant_identifier_names

import 'package:dio/dio.dart';
import '/services/service_url.dart';
import '/util/app_user.dart';
import '/util/shared_preferences.dart';
import '/model/login/sign_up_model.dart';
import '/dependency_injection/setup.dart';
import '/model/login/sign_in_model.dart';
import '/model/login/login_model.dart';
import '/services/interface/login_interface.dart';

class LoginService implements LoginInterface {
  final Dio dio = getIt<Dio>();
  final SharedPreferencesUtil preferencesUtil = getIt<SharedPreferencesUtil>();

  final String _SIGN_IN = "sign-in";
  final String _SIGN_UP = "sign-up";

  @override
  Future<LoginModel> signIn(SignInRequestModel signInRequestModel) async {
    Response<dynamic> response = await dio.post(
      ServiceUrl.BASE_URL + _SIGN_IN,
      data: signInRequestModel.toJson(),
      options: Options(
        validateStatus: (status) => true,
      ),
    );

    if (response.statusCode != ServiceUrl.SUCCESS) {
      return LoginModel(
        isSucces: false,
        message: response.data.toString(),
      );
    }

    LoginTokenModel userModel = LoginTokenModel.fromJson(response.data);
    AppUser.LOGIN_TOKEN_MODEL = userModel;
    preferencesUtil.setString(preferencesUtil.TOKEN, userModel.token!);
    preferencesUtil.setString(preferencesUtil.USER_ID, userModel.userId!);

    return LoginModel(
      isSucces: true,
      userModel: userModel,
    );
  }

  @override
  Future<LoginModel> signUp(SignUpRequestModel signUpRequestModel) async {
    Response<dynamic> response = await dio.post(
      ServiceUrl.BASE_URL + _SIGN_UP,
      data: signUpRequestModel.toJson(),
      options: Options(
        validateStatus: (status) => true,
      ),
    );

    if (response.statusCode != ServiceUrl.SUCCESS) {
      return LoginModel(
        isSucces: false,
        message: response.data["message"] ?? "",
      );
    }

    LoginTokenModel userModel = LoginTokenModel.fromJson(response.data);
    AppUser.LOGIN_TOKEN_MODEL = userModel;
    preferencesUtil.setString(preferencesUtil.TOKEN, userModel.token!);
    preferencesUtil.setString(preferencesUtil.USER_ID, userModel.userId!);

    return LoginModel(
      isSucces: true,
      userModel: userModel,
    );
  }
}
