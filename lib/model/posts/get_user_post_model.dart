class GetUserPostModel {
  GetUserPostModel({
    this.photoName,
    this.description,
    this.nameSurname,
    this.groupId,
    required this.creationTime,
    this.likeUserId,
    this.comment,
    required this.objectId,
    required this.userId,
    this.groupName,
  });
  String? photoName;
  String? nameSurname;
  String? description;
  String? groupId;
  late final int creationTime;
  List<String?>? likeUserId;
  List<Comment?>? comment;
  String? groupName;
  late final String objectId;
  late final String userId;

  GetUserPostModel.fromJson(Map<String, dynamic> json) {
    photoName = json['photoName'];
    nameSurname = json['nameSurname'];
    description = json['description'];
    groupName = json['groupName'];
    groupId = json['groupId'];
    creationTime = json['creationTime'];

    try {
      if (json['likeUserId'] != null) {
        likeUserId = List.castFrom<dynamic, String>(json['likeUserId']);
      }

      if (json['comment'] != null) {
        comment =
            List.from(json['comment']).map((e) => Comment.fromJson(e)).toList();
      }
    } catch (e) {
      e.toString();
    }

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
    _data['groupName'] = groupName;
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
  String? photoName;
  String? nameSurname;
  late final int creationTime;

  Comment.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    comment = json['comment'];
    photoName = json['photoName'];
    creationTime = json['creationTime'];
    nameSurname = json['nameSurname'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['userId'] = userId;
    _data['comment'] = comment;
    _data['photoName'] = photoName;
    _data['creationTime'] = creationTime;
    _data['nameSurname'] = nameSurname;
    return _data;
  }
}
