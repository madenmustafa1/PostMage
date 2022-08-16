class UserModel {
  final String mail;
  final String? username;
  final String userUUID;
  final bool? emailVerified;
  final String? nameSurname;

  UserModel({
    required this.mail,
    this.username,
    this.nameSurname,
    required this.userUUID,
    this.emailVerified,
  });

  Map<String, dynamic> asMap() => {
        'nameSurname': nameSurname,
        'mail': mail,
        'userUUID': userUUID,
        'username': username,
      };
}
