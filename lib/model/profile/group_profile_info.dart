import 'package:flutter/material.dart';

import 'following_model.dart';

class UserProfileInfoModel {
  UserProfileInfoModel({
    required this.nameSurname,
    required this.mail,
    required this.phoneNumber,
    required this.gender,
    this.profilePhotoUrl,
    required this.userId,
    required this.groups,
    required this.followersSize,
    required this.followingSize,
    required this.userRole,
    required this.following,
    required this.followers,
    required this.creationTime,
  });
  late final String? nameSurname;
  late final String? mail;
  late final String? phoneNumber;
  late final int? gender;
  late final String? profilePhotoUrl;
  late final String? userId;
  late final List<Groups?>? groups;
  late final int? followersSize;
  late final int? followingSize;
  late final int? userRole;
  late final List<Following?>? following;
  late final List<Followers?>? followers;
  late final int? creationTime;

  UserProfileInfoModel.fromJson(Map<String, dynamic> json) {
    nameSurname = json['nameSurname'];
    mail = json['mail'];
    phoneNumber = json['phoneNumber'];
    gender = json['gender'];
    profilePhotoUrl = json['profilePhotoUrl'];
    userId = json['userId'];
    if (json['groups'] != null) {
      groups =
          List.from(json['groups']).map((e) => Groups.fromJson(e)).toList();
    }
    followersSize = json['followersSize'];
    followingSize = json['followingSize'];
    userRole = json['userRole'];
    following =
        List.from(json['following']).map((e) => Following.fromJson(e)).toList();
    followers =
        List.from(json['followers']).map((e) => Followers.fromJson(e)).toList();
    creationTime = json['creationTime'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['nameSurname'] = nameSurname;
    _data['mail'] = mail;
    _data['phoneNumber'] = phoneNumber;
    _data['gender'] = gender;
    _data['profilePhotoUrl'] = profilePhotoUrl;
    _data['userId'] = userId;
    _data['groups'] = groups?.map((e) => e?.toJson()).toList();
    _data['followersSize'] = followersSize;
    _data['followingSize'] = followingSize;
    _data['userRole'] = userRole;
    _data['following'] = following?.map((e) => e?.toJson()).toList();
    _data['followers'] = followers?.map((e) => e?.toJson()).toList();
    _data['creationTime'] = creationTime;
    return _data;
  }
}

class Groups {
  Groups({
    required this.groupId,
    required this.groupName,
    required this.description,
    required this.photoName,
    required this.adminIds,
    required this.creationTime,
    required this.groupUsers,
  });
  late final String groupId;
  late final String groupName;
  late final String description;
  late final String photoName;
  late final List<String?>? adminIds;
  late final int creationTime;
  late final List<GroupUsers> groupUsers;

  Groups.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    groupId = json['groupId'];
    groupName = json['groupName'];
    description = json['description'];
    photoName = json['photoName'];
    if (json['adminIds'] != null) {
      var res = List.castFrom<dynamic, dynamic>(json['adminIds']);
      if (res.isNotEmpty) {
        adminIds = List.castFrom<String?, String?>(json['adminIds']);
      }
    }
    creationTime = json['creationTime'];

    groupUsers = List.from(json['groupUsers'])
        .map((e) => GroupUsers.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['groupId'] = groupId;
    _data['groupName'] = groupName;
    _data['description'] = description;
    _data['photoName'] = photoName;
    _data['adminIds'] = adminIds;
    _data['creationTime'] = creationTime;
    _data['groupUsers'] = groupUsers;
    return _data;
  }
}

class Followers {
  Followers({
    required this.nameSurname,
    required this.userId,
    this.photoUrl,
  });
  late final String nameSurname;
  late final String userId;
  late final String? photoUrl;

  Followers.fromJson(Map<String, dynamic> json) {
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

class GroupUsers {
  GroupUsers({
    required this.name,
    required this.id,
    this.photoUrl,
  });
  late final String name;
  late final String id;
  late final String? photoUrl;

  GroupUsers.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    photoUrl = json['photoUrl'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name;
    _data['id'] = id;
    _data['photoUrl'] = photoUrl;
    return _data;
  }
}
