import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/model/profile/group_profile_info.dart';
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

final getProfileInfoProvider =
    StateNotifierProvider<GetProfileInfoNotifier, UserProfileInfoModel?>((ref) {
  return GetProfileInfoNotifier(ref);
});

class GetProfileInfoNotifier extends StateNotifier<UserProfileInfoModel?> {
  GetProfileInfoNotifier(this.ref) : super(null);

  final Ref ref;

  void update(UserProfileInfoModel? model) => state = model;
  void get(UserProfileInfoModel? model) => state;
}