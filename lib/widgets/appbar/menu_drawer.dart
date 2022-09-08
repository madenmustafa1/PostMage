/*
import 'package:flutter/material.dart';
import '../util/app_util.dart';
import '../util/color_util.dart';
import '../util/router.dart';
import '../widgets/text_and_button/simple_text.dart';
import '../dependency_injection/setup.dart';
import '../util/constants.dart';


// ignore: must_be_immutable
class MenuDrawer extends StatelessWidget {
  MenuDrawer({Key? key}) : super(key: key);

  Constants constants = getIt<Constants>();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: ColorUtil.MAIN_COLOR,
            ),
            child: SimpleText(
              text: constants.appName,
              optionalTextSize: AppUtil.getHeight(context) / 22,
              textColor: ColorUtil.WHITE,
            ),
          ),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            //trailing: const Icon(Icons.exit_to_app),
            title: Text(constants.signOut),
            onTap: () {
              FirebaseAuth.instance.signOut();

              Navigator.of(context).pushNamedAndRemoveUntil(
                  CRouter.SIGN_IN, (Route<dynamic> route) => false);
            },
          ),
        ],
      ),
    );
  }
}
*/
