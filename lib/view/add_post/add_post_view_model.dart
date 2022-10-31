import 'dart:io';
import 'dart:typed_data';

import 'package:image_picker/image_picker.dart';
import 'package:mdntls/model/posts/add_post_model.dart';

import '/dependency_injection/setup.dart';
import '/services/repo/app_http_repository.dart';

class AddPostViewModel {
  final AppHttpRepository _appHttpRepository = getIt<AppHttpRepository>();

  Future<bool> sharePost(
      Uint8List? selectedImageBytes, String userComment, XFile? xFile) async {
    if (selectedImageBytes == null) return false;
    if (xFile == null) return false;
    File file = File(xFile.path);

    var result = await _appHttpRepository.addPost(
      AddPostModel(
        file: file,
        description: userComment,
      ),
    );

    return result.data ?? false;
  }
}
