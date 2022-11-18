class GetMyGroupListModel {
  String? groupName;
  String? photoName;
  int? totalUser;
  bool? isAdmin;
  List<String>? groupUsersId;

  GetMyGroupListModel(
      {this.groupName,
      this.photoName,
      this.totalUser,
      this.isAdmin,
      this.groupUsersId});

  GetMyGroupListModel.fromJson(Map<String, dynamic> json) {
    groupName = json['groupName'];
    photoName = json['photoName'];
    totalUser = json['totalUser'];
    isAdmin = json['isAdmin'];
    if (json['groupUsersId'] != null) {
      groupUsersId = [];
      json['groupUsersId'].forEach((v) {
        groupUsersId!.add(v);
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['groupName'] = groupName;
    data['photoName'] = photoName;
    data['totalUser'] = totalUser;
    data['isAdmin'] = isAdmin;
    if (groupUsersId != null) {
      data['groupUsersId'] = groupUsersId!.map((v) => v).toList();
    }
    return data;
  }
}
