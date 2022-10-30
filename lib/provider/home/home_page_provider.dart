import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/model/posts/get_user_post_model.dart';

final getFollowedUsersPostsProvider = StateNotifierProvider<
    GetFollowedUsersPostsNotifier, List<GetUserPostModel?>?>((ref) {
  return GetFollowedUsersPostsNotifier(ref);
});

class GetFollowedUsersPostsNotifier
    extends StateNotifier<List<GetUserPostModel?>?> {
  GetFollowedUsersPostsNotifier(this.ref) : super(null);

  final Ref ref;

  void update(List<GetUserPostModel?> model) => state = model;
  void get(List<GetUserPostModel?> model) => state;
}
