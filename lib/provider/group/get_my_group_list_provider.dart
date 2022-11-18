import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/model/group/get_my_group_list_model.dart';

final getMyGroupListProvider = StateNotifierProvider<
    GetMyGroupListNotifier, List<GetMyGroupListModel?>?>((ref) {
  return GetMyGroupListNotifier(ref);
});

class GetMyGroupListNotifier
    extends StateNotifier<List<GetMyGroupListModel?>?> {
  GetMyGroupListNotifier(this.ref) : super(null);

  final Ref ref;

  void update(List<GetMyGroupListModel?>? model) => state = model;
  void get(List<GetMyGroupListModel?>? model) => state;
}
