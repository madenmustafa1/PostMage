import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/model/posts/get_user_post_model.dart';

final getGroupPostsProvider = StateNotifierProvider<
    GetGroupPostsNotifier, List<GetUserPostModel?>?>((ref) {
  return GetGroupPostsNotifier(ref);
});

class GetGroupPostsNotifier
    extends StateNotifier<List<GetUserPostModel?>?> {
  GetGroupPostsNotifier(this.ref) : super(null);

  final Ref ref;

  void update(List<GetUserPostModel?> model) => state = model;
  void get(List<GetUserPostModel?> model) => state;
}
