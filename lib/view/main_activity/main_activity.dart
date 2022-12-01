import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../enum/list_type.dart';
import '../../provider/home/home_page_provider.dart';
import '../../util/color_util.dart';
import '../../util/router.dart';
import '../../widgets/appbar_and_bottombar/basic_appbar.dart';
import '../../dependency_injection/setup.dart';
import '../../widgets/appbar_and_bottombar/bottombar_menu.dart';
import '../home/home_view_model.dart';

class MainActivity extends ConsumerStatefulWidget {
  MainActivity({
    Key? key,
  }) : super(key: key);

  final BottombarMenu _bottombarMenu = getIt<BottombarMenu>();
  final HomeViewModel _homeViewModel = getIt<HomeViewModel>();

  @override
  _MainActivityState createState() => _MainActivityState();
}

class _MainActivityState extends ConsumerState<MainActivity> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(
        title: widget._bottombarMenu.indexToAppbarName(_selectedIndex),
      ),
      body: Center(
        child: BottombarMenu.widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: widget._bottombarMenu.bottomNavigationBar(
        _selectedIndex,
        (p0) => _onItemTapped(p0),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          var result = await Navigator.pushNamed(context, CRouter.ADD_POST);
          if (result != null) forceUpdatePostList(ref);
        },
        backgroundColor: ColorUtil.MAIN_COLOR,
      ),
    );
  }

  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void forceUpdatePostList(WidgetRef ref) async {
    var model = await widget._homeViewModel.getUsersPosts(
      listType: ListType.HOME,
    );
    if (model != null) {
      ref.read(getFollowedUsersPostsProvider.notifier).update(model);
    }
  }
}
