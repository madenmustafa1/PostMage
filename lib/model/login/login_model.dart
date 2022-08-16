import 'package:mdntls/model/login/user_model.dart';

class LoginControlModel {
  final String message;
  final bool isSucces;
  final UserModel? userModel;

  LoginControlModel({
    required this.message,
    required this.isSucces,
    this.userModel
  });
}
