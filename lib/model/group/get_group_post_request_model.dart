import 'dart:convert';

import 'package:flutter/foundation.dart';

class GetGroupPostRequestModel {
  List<String> groupId;
  GetGroupPostRequestModel({
    required this.groupId,
  });

  GetGroupPostRequestModel copyWith({
    List<String>? groupId,
  }) {
    return GetGroupPostRequestModel(
      groupId: groupId ?? this.groupId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'groupId': groupId,
    };
  }

  factory GetGroupPostRequestModel.fromMap(Map<String, dynamic> map) {
    return GetGroupPostRequestModel(
      groupId: List<String>.from(map['groupId']),
    );
  }

  String toJson() => json.encode(toMap());

  factory GetGroupPostRequestModel.fromJson(String source) => GetGroupPostRequestModel.fromMap(json.decode(source));

  @override
  String toString() => 'GetGroupPostRequestModel(groupId: $groupId)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is GetGroupPostRequestModel &&
      listEquals(other.groupId, groupId);
  }

  @override
  int get hashCode => groupId.hashCode;
}
