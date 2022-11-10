import 'package:flutter/material.dart';
import 'package:mdntls/util/router.dart';
import '/util/color_util.dart';
import '/widgets/text_and_button/simple_text.dart';
import '/dependency_injection/setup.dart';
import '/util/constants.dart';

Constants constants = getIt<Constants>();
Widget customDrawerMenu(BuildContext context) {
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        DrawerHeader(
          decoration: BoxDecoration(
            color: ColorUtil.MAIN_COLOR,
          ),
          //App name
          child: SimpleText(
            text: constants.appName,
            textColor: ColorUtil.WHITE,
          ),
        ),
        //HomePageTitle
        ListTile(
          leading: const Icon(
            Icons.home,
          ),
          title: Text(constants.homePageTitle),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        //ProfilePageTitle
        ListTile(
          leading: const Icon(Icons.person),
          title: Text(constants.profilePageTitle),
          onTap: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, CRouter.PROFILE);
          },
        ),
        //AddUserPageTitle
        ListTile(
          leading: const Icon(Icons.add),
          title: Text(constants.addUserPageTitle),
          onTap: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, CRouter.ADD_USER);
          },
        ),
        //MakeGroupPageTitle
        ListTile(
          leading: const Icon(Icons.group),
          title: Text(constants.makeGroupPageTitle),
          onTap: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, CRouter.CREATE_GROUP);
          },
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.0),
          child: Divider(
            color: Colors.black45,
          ),
        ),
        //Help
        ListTile(
          leading: const Icon(Icons.help),
          title: Text(constants.TR_HELP),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        //Exit
        ListTile(
          leading: const Icon(Icons.exit_to_app),
          title: Text(constants.TR_EXIT),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ],
    ),
  );
}
