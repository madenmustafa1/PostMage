class GetFollowerDataModel {
  GetFollowerDataModel({
    required this.following,
    required this.followers,
  });
  late final List<Following> following;
  late final List<Following> followers;

  GetFollowerDataModel.fromJson(Map<String, dynamic> json) {
    following =
        List.from(json['following']).map((e) => Following.fromJson(e)).toList();
    followers =
        List.from(json['followers']).map((e) => Following.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['following'] = following.map((e) => e.toJson()).toList();
    _data['followers'] = followers.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Following {
  Following({
    required this.nameSurname,
    required this.userId,
    this.photoUrl,
  });
  late final String nameSurname;
  late final String userId;
  late final String? photoUrl;

  Following.fromJson(Map<String, dynamic> json) {
    nameSurname = json['nameSurname'];
    userId = json['userId'];
    photoUrl = json['photoUrl'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['nameSurname'] = nameSurname;
    _data['userId'] = userId;
    _data['photoUrl'] = photoUrl;
    return _data;
  }
}
