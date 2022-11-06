import 'following_model.dart';

class PutFollowerDataModel {
  Following? following;
  Following? followers;

  PutFollowerDataModel({
    this.following,
    this.followers,
  });

  PutFollowerDataModel.fromJson(Map<String, dynamic> json) {
    following = json['following'] != null
        ? Following.fromJson(json['following'])
        : null;
    followers = json['followers'] != null
        ? Following.fromJson(json['followers'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (following != null) {
      data['following'] = following!.toJson();
    }
    if (followers != null) {
      data['followers'] = followers!.toJson();
    }
    return data;
  }
}
