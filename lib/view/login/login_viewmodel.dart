import '/model/login/sign_in_model.dart';
import '/services/repo/login_repository.dart';
import '/dependency_injection/setup.dart';
import '/model/login/login_model.dart';
import '/model/login/sign_up_model.dart';
import '/util/constants.dart';

class LoginViewModel {
  Constants constants = getIt<Constants>();
  LoginRepository loginRepository = getIt<LoginRepository>();

  Future<LoginModel> signIn(String email, String password) async {
    String errorDesc = "";
    try {
      if (email.trim().isEmpty) {
        errorDesc = "E-mail alanı boş bırakılamaz";
        return LoginModel(
          message: errorDesc,
          isSucces: false,
        );
      }

      if (password.trim().isEmpty) {
        errorDesc = "Şifre alanı boş bırakılamaz";
        return LoginModel(
          message: errorDesc,
          isSucces: false,
        );
      }

      return await loginRepository.signIn(
        SignInRequestModel(
          mail: email,
          password: password,
        ),
      );
    } catch (e) {
      return LoginModel(
        message: errorDesc,
        isSucces: false,
      );
    }
  }

  Future<LoginModel> signUp(SignUpRequestModel signUpModel) async {
    String mail = signUpModel.mail?.trim() ?? "";
    String username = signUpModel.nameSurname?.trim() ?? "";
    String password = signUpModel.password?.trim() ?? "";
    String rePassword = signUpModel.password?.trim() ?? "";

    if (mail.isEmpty) {
      return LoginModel(message: constants.errorMailMessage, isSucces: false);
    }
    if (!emailValidation(mail)) {
      return LoginModel(
        message: constants.errorMailValidationMessage,
        isSucces: false,
      );
    }

    if (username.isEmpty) {
      return LoginModel(
          message: constants.errorUsernameMessage, isSucces: false);
    }

    if (password.isEmpty) {
      return LoginModel(
          message: constants.errorPasswordMessage, isSucces: false);
    }

    if (rePassword.isEmpty) {
      return LoginModel(
        message: constants.errorPasswordMessage,
        isSucces: false,
      );
    }

    if (password != rePassword) {
      return LoginModel(
        message: constants.errorPasswordNotMatchMessage,
        isSucces: false,
      );
    }

    return await loginRepository.signUp(signUpModel);
  }

  bool emailValidation(String email) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }
}
