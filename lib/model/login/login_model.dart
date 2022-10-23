class LoginModel {
  final String? message;
  final bool isSucces;
  final LoginTokenModel? userModel;

  LoginModel({
    this.message,
    required this.isSucces,
    this.userModel,
  });
}

class LoginTokenModel {
  String? token;
  String? userId;
  bool? isSuccess;

  LoginTokenModel({
    this.token,
    this.userId,
    this.isSuccess,
  });

  LoginTokenModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    userId = json['userId'];
    isSuccess = json['isSuccess'];
  }
}
