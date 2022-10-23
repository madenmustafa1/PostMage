class SignUpRequestModel {
  String? nameSurname;
  String? mail;
  String? password;
  String? phoneNumber;
  int? gender;

  SignUpRequestModel(
      {this.nameSurname,
      this.mail,
      this.password,
      this.phoneNumber,
      this.gender});

  SignUpRequestModel.fromJson(Map<String, dynamic> json) {
    nameSurname = json['nameSurname'];
    mail = json['mail'];
    password = json['password'];
    phoneNumber = json['phoneNumber'];
    gender = json['gender'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nameSurname'] = nameSurname;
    data['mail'] = mail;
    data['password'] = password;
    data['phoneNumber'] = phoneNumber;
    data['gender'] = this.gender;
    return data;
  }
}
