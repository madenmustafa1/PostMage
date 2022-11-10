class AddUserToGroupModel {
  AddUserToGroupModel({
    required this.id,
    required this.groupId,
  });
  late final String id;
  late final String groupId;


  AddUserToGroupModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    groupId = json['groupId'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['groupId'] = groupId;
    return _data;
  }
}