class CreateGroupResponseModel {
  String? groupId;
  String? groupName;
  String? description;
  String? photoName;
  List<String>? adminIds;
  int? creationTime;
  List<GroupUsers>? groupUsers;

  CreateGroupResponseModel({
    this.groupId,
    this.groupName,
    this.description,
    this.photoName,
    this.adminIds,
    this.creationTime,
    this.groupUsers,
  });

  CreateGroupResponseModel.fromJson(Map<String, dynamic> json) {
    groupId = json['groupId'];
    groupName = json['groupName'];
    description = json['description'];
    photoName = json['photoName'];
    adminIds = json['adminIds'].cast<String>();
    creationTime = json['creationTime'];
    if (json['groupUsers'] != null) {
      groupUsers = <GroupUsers>[];
      json['groupUsers'].forEach((v) {
        groupUsers!.add(GroupUsers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['groupId'] = groupId;
    data['groupName'] = groupName;
    data['description'] = description;
    data['photoName'] = photoName;
    data['adminIds'] = adminIds;
    data['creationTime'] = creationTime;
    if (groupUsers != null) {
      data['groupUsers'] = groupUsers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GroupUsers {
  String? name;
  String? profileUrl;
  String? id;

  GroupUsers({this.name, this.profileUrl, this.id});

  GroupUsers.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    profileUrl = json['profileUrl'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['profileUrl'] = profileUrl;
    data['id'] = id;
    return data;
  }
}
