class MyGroupListInfo {
  MyGroupListInfo({
    required this.name,
    this.profileUrl,
    required this.id,
  });
  late final String name;
  late final String? profileUrl;
  late final String id;

  MyGroupListInfo.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    profileUrl = json['profileUrl'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name;
    _data['profileUrl'] = profileUrl;
    _data['id'] = id;
    return _data;
  }
}
