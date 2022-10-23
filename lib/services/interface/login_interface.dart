import 'package:mdntls/model/login/sign_up_model.dart';

import '/model/login/login_model.dart';
import '/model/login/sign_in_model.dart';

abstract class LoginInterface {
  Future<LoginModel> signUp(SignUpRequestModel signUpRequestModel);
  Future<LoginModel> signIn(SignInRequestModel signInRequestModel);
}
