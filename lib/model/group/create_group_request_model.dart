import 'dart:io';

class CreateGroupRequestModel {
  File file;
  String? groupName;
  CreateGroupRequestModel({
    required this.file,
    this.groupName,
  });
}
