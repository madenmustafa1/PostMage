import 'package:mdntls/model/posts/add_post_model.dart';

import 'dart:ffi';

import '../data_layer.dart';
import '/dependency_injection/setup.dart';
import '../service/app_http_service.dart';
import '/model/posts/get_user_post_model.dart';

import '../interface/app_http_interface.dart';

class AppHttpRepository implements AppHttpInterface {
  final AppHttpService _appHttpService = getIt<AppHttpService>();


  @override
  Future<DataLayer<List<GetUserPostModel?>?>> getFollowedUsersPosts({
    int limit = 100,
  }) async {
    return await _appHttpService.getFollowedUsersPosts(
      limit: limit,
    );
  }

  @override
  Future<DataLayer<bool>> addPost(AddPostModel model) async {
    return await _appHttpService.addPost(model);
  }
}
