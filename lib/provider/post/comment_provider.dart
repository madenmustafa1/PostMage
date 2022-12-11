import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../model/posts/get_user_post_model.dart';

final commentProvider =
    StateNotifierProvider<CommentNotifierProvider, List<Comment>?>((ref) {
  return CommentNotifierProvider(ref);
});

class CommentNotifierProvider extends StateNotifier<List<Comment>?> {
  CommentNotifierProvider(this.ref) : super(null);
  final Ref ref;
  void updateComments(List<Comment> model) => state = model;
  void resetComments () => state = null;
}
