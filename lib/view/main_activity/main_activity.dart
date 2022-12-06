import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mdntls/widgets/widget_util/calc_sized_box.dart';
import '../../enum/bottom_nav_state.dart';
import '../../widgets/appbar_and_bottombar/drawer_menu.dart';
import '../../widgets/other/custom_fab.dart';
import '../../enum/list_type.dart';
import '../../provider/home/home_page_provider.dart';
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Center(
              child: BottombarMenu.widgetOptions.elementAt(_selectedIndex),
            ),
          ),
          //CalcSizedBox(calc: 200)
        ],
      ),
      drawer: customDrawerMenu(context),
      bottomNavigationBar: widget._bottombarMenu.bottomNavigationBar(
        _selectedIndex,
        (p0) => _onItemTapped(p0),
      ),
      floatingActionButton: returnFab(),
    );
  }

  Widget returnFab() {
    if (_selectedIndex == BottomNavState.GROUP.index) {
      return CustomFab.allGroupsFab(context);
    } else if (_selectedIndex == BottomNavState.PROFILE.index) {
      return CustomFab.homeOrProfileFab(
        context,
        Icons.person_add,
        () => Navigator.pushNamed(context, CRouter.ADD_USER),
      );
    }

    return CustomFab.homeOrProfileFab(
      context,
      Icons.add,
      () => homeFabListener(),
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

  void homeFabListener() async {
    var result = await Navigator.pushNamed(context, CRouter.ADD_POST);
    if (result != null) forceUpdatePostList(ref);
  }
}
