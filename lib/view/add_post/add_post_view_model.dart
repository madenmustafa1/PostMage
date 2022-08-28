import 'dart:typed_data';

class AddPostViewModel {
  Future<bool> sharePost(
      Uint8List? selectedImageBytes, String userComment) async {
    if (selectedImageBytes == null) return false;

    return true;
  }
}
