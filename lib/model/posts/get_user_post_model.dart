class GetUserPostModel {
  GetUserPostModel({
    this.photoName,
    this.description,
    this.nameSurname,
    this.groupId,
    required this.creationTime,
    required this.likeUserId,
    this.comment,
    required this.objectId,
    required this.userId,
  });
  String? photoName;
  String? nameSurname;
  String? description;
  String? groupId;
  late final int creationTime;
  late final List<String?>? likeUserId;
  List<Comment?>? comment;
  late final String objectId;
  late final String userId;

  GetUserPostModel.fromJson(Map<String, dynamic> json) {
    photoName = json['photoName'];
    nameSurname = json['nameSurname'];
    description = json['description'];
    groupId = json['groupId'];
    creationTime = json['creationTime'];

    try {
      if (json['likeUserId'] != null) {
        likeUserId = List?.castFrom<dynamic, String>(json['likeUserId']);
      }

      if (json['comment'] != null) {
        comment =
            List.from(json['comment']).map((e) => Comment.fromJson(e)).toList();
      }
    } catch (e) {}

    objectId = json['objectId'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['photoName'] = photoName;
    _data['nameSurname'] = nameSurname;
    _data['description'] = description;
    _data['groupId'] = groupId;
    _data['creationTime'] = creationTime;
    _data['likeUserId'] = likeUserId;
    _data['comment'] = comment?.map((e) => e?.toJson()).toList();
    _data['objectId'] = objectId;
    _data['userId'] = userId;
    return _data;
  }
}

class Comment {
  Comment({
    required this.userId,
    required this.comment,
    required this.creationTime,
  });
  late final String userId;
  late final String comment;
  late final int creationTime;

  Comment.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    comment = json['comment'];
    creationTime = json['creationTime'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['userId'] = userId;
    _data['comment'] = comment;
    _data['creationTime'] = creationTime;
    return _data;
  }
}
