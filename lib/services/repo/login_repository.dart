import '/dependency_injection/setup.dart';
import '/model/login/sign_up_model.dart';
import '/services/service/login_service.dart';
import '/model/login/sign_in_model.dart';
import '/model/login/login_model.dart';
import '/services/interface/login_interface.dart';

class LoginRepository implements LoginInterface {
  final LoginService _loginService = getIt<LoginService>();

  @override
  Future<LoginModel> signIn(SignInRequestModel signInRequestModel) async {
    try {
      return await _loginService.signIn(signInRequestModel);
    } catch (e) {
      return LoginModel(isSucces: false, message: e.toString());
    }
  }
 
  @override
  Future<LoginModel> signUp(SignUpRequestModel signUpRequestModel) async {
    try {
      return await _loginService.signUp(signUpRequestModel);
    } catch (e) {
      return LoginModel(isSucces: false, message: e.toString());
    }
  }
}
