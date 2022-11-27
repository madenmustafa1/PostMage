class Following {
  String? nameSurname;
  String? userId;
  String? photoUrl;

  Following({
    this.nameSurname,
    this.userId,
    this.photoUrl,
  });

  Following.fromJson(Map<String, dynamic> json) {
    nameSurname = json['nameSurname'];
    userId = json['userId'];
    photoUrl = json['photoUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['nameSurname'] = nameSurname;
    data['userId'] = userId;
    data['photoUrl'] = photoUrl;
    return data;
  }
}
