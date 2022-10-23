class SignInRequestModel {
  String? mail;
  String? password;

  SignInRequestModel({
    this.mail,
    this.password,
  });

  SignInRequestModel.fromJson(Map<String, dynamic> json) {
    mail = json['mail'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['mail'] = mail;
    data['password'] = password;
    return data;
  }
}
