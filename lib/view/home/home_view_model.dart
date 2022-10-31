
import '/services/data_layer.dart';
import '/model/posts/get_user_post_model.dart';
import '/services/repo/app_http_repository.dart';
import '/dependency_injection/setup.dart';

class HomeViewModel {
  final AppHttpRepository _appHttpRepository = getIt<AppHttpRepository>();

  Future<List<GetUserPostModel?>?> getFollowedUsersPosts({
    int limit = 100,
  }) async {
    var model = await _appHttpRepository.getFollowedUsersPosts(limit: limit);

    if (model.status == DataStatus.SUCCESS) {
      if (model.data != null) {
        return model.data!;
      }
    }
    return [];
  }
}
