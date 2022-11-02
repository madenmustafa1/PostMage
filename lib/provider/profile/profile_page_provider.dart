import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/model/posts/get_user_post_model.dart';

final getMyPostProvider =
    StateNotifierProvider<GetMyPostNotifier, List<GetUserPostModel?>?>((ref) {
  return GetMyPostNotifier(ref);
});

class GetMyPostNotifier extends StateNotifier<List<GetUserPostModel?>?> {
  GetMyPostNotifier(this.ref) : super(null);

  final Ref ref;

  void update(List<GetUserPostModel?> model) => state = model;
  void get(List<GetUserPostModel?> model) => state;
}
