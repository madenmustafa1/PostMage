class UpdatePostModel {
  String? objectId;
  String? description;
  CommentModel? commentModel;
  String? likeUserId;

  UpdatePostModel({
    this.objectId,
    this.description,
    this.commentModel,
    this.likeUserId,
  });

  UpdatePostModel.fromJson(Map<String, dynamic> json) {
    objectId = json['objectId'];
    description = json['description'];
    commentModel =
        json['comment'] != null ? CommentModel.fromJson(json['comment']) : null;
    likeUserId = json['likeUserId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['objectId'] = objectId;
    data['description'] = description;
    if (commentModel != null) {
      data['comment'] = commentModel!.toJson();
    }
    data['likeUserId'] = likeUserId;
    return data;
  }
}

class CommentModel {
  String? userId;
  String? comment;

  CommentModel({this.userId, this.comment});

  CommentModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    comment = json['comment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['comment'] = comment;
    return data;
  }
}
