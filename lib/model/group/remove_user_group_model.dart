class UserGroupModel {
  UserGroupModel({
    this.groupId,
    required this.id,
  });
  late final String? groupId;
  late final String id;

  UserGroupModel.fromJson(Map<String, dynamic> json) {
    groupId = json['groupId'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['groupId'] = groupId;
    _data['id'] = id;
    return _data;
  }
}
