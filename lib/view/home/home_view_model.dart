// ignore_for_file: empty_catches

import '../../enum/list_type.dart';
import '/services/data_layer.dart';
import '/model/posts/get_user_post_model.dart';
import '/services/repo/app_http_repository.dart';
import '/dependency_injection/setup.dart';

class HomeViewModel {
  final AppHttpRepository _appHttpRepository = getIt<AppHttpRepository>();

  Future<List<GetUserPostModel?>?> getUsersPosts({
    int limit = 100,
    required ListType listType,
  }) async {
    try {
      DataLayer<List<GetUserPostModel?>?> model;
      if (listType == ListType.HOME) {
        model = await _appHttpRepository.getFollowedUsersPosts(limit: limit);
      } else {
        model = await _appHttpRepository.getMyPosts();
      }
      if (model.status == DataStatus.SUCCESS) {
        if (model.data != null) {
          return model.data!;
        }
      }
    } catch (e) {}

    return [];
  }
}
