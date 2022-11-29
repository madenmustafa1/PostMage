//DataLayer<List<MyGroupListInfo?>?> result

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/model/group/get_my_group_list_info.dart';
import '/services/data_layer.dart';

final getGroupListInfoProvider = StateNotifierProvider<GetGroupListInfoNotifier,
    DataLayer<List<MyGroupListInfo?>?>>((ref) {
  return GetGroupListInfoNotifier(ref);
});

class GetGroupListInfoNotifier
    extends StateNotifier<DataLayer<List<MyGroupListInfo?>?>> {
  GetGroupListInfoNotifier(this.ref)
      : super(DataLayer(status: DataStatus.LOADING));

  final Ref ref;

  void update(DataLayer<List<MyGroupListInfo?>?> model) => state = model;
  void get(DataLayer<List<MyGroupListInfo?>?> model) => state;
}
