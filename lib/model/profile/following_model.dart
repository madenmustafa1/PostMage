class Following {
  String? nameSurname;
  String? userId;

  Following({
    this.nameSurname,
    this.userId,
  });

  Following.fromJson(Map<String, dynamic> json) {
    nameSurname = json['nameSurname'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['nameSurname'] = nameSurname;
    data['userId'] = userId;
    return data;
  }
}
