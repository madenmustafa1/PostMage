import '/model/posts/add_post_model.dart';
import '../data_layer.dart';
import '/model/posts/get_user_post_model.dart';

abstract class AppHttpInterface {
  Future<DataLayer<List<GetUserPostModel?>?>> getFollowedUsersPosts({
    int limit = 100,
  });

  Future<DataLayer<bool>> addPost(AddPostModel model);
}
