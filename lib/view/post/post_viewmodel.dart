import 'package:mdntls/model/posts/update_post_model.dart';

import '../../dependency_injection/setup.dart';
import '../../model/posts/get_user_post_model.dart';
import '../../services/data_layer.dart';
import '../../services/repo/app_http_repository.dart';
import '../../util/app_user.dart';
import '../../util/constants.dart';

class PostViewModel {
  final AppHttpRepository _appHttpRepository = getIt<AppHttpRepository>();
  final Constants _constants = getIt<Constants>();

  Future<DataLayer<GetUserPostModel?>> getPost(String postId) async {
    try {
      return _appHttpRepository.getPost(postId);
    } catch (e) {
      return DataLayer(
          errorData: ErrorData(
        reason: _constants.TR_GENERAL_ERROR,
        statusCode: DataStatus.ERROR,
      ));
    }
  }

  Future<DataLayer<List<Comment>?>> getComments(String postId) async {
    try {
      return _appHttpRepository.getComments(postId);
    } catch (e) {
      return DataLayer(
          errorData: ErrorData(
        reason: _constants.TR_GENERAL_ERROR,
        statusCode: DataStatus.ERROR,
      ));
    }
  }

  Future<DataLayer<bool>> addComment({
    required String postId,
    required String comment,
  }) async {
    try {
      UpdatePostModel model = UpdatePostModel(
        objectId: postId,
        commentModel: CommentModel(
          comment: comment,
          userId: AppUser.LOGIN_TOKEN_MODEL?.userId.toString(),
        ),
      );
      return _appHttpRepository.putUpdatePost(model);
    } catch (e) {
      return DataLayer(
          errorData: ErrorData(
        reason: _constants.TR_GENERAL_ERROR,
        statusCode: DataStatus.ERROR,
      ));
    }
  }
}
