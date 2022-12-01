import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../widgets/appbar_and_bottombar/basic_appbar.dart';
import '../../dependency_injection/setup.dart';
import '../../util/constants.dart';
import '../../widgets/appbar_and_bottombar/bottombar_menu.dart';

class MainActivity extends ConsumerStatefulWidget {
  MainActivity({
    Key? key,
  }) : super(key: key);

  final Constants _constants = getIt<Constants>();
  final BottombarMenu _bottombarMenu = getIt<BottombarMenu>();

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
    );
  }

  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}