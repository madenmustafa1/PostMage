import 'dart:io';

class AddPostModel {
  File file;
  String? description;
  String? groupId;
  AddPostModel({
    required this.file,
    this.description,
    this.groupId,
  });
}
