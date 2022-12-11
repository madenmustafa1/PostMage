import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../model/posts/get_user_post_model.dart';

final postProvider =
    StateNotifierProvider<PostNotifierProvider, GetUserPostModel?>((ref) {
  return PostNotifierProvider(ref);
});

class PostNotifierProvider extends StateNotifier<GetUserPostModel?> {
  PostNotifierProvider(this.ref) : super(null);
  final Ref ref;
  void updateComments(GetUserPostModel model) => state = model;
  void resetComments() => state = null;
}


