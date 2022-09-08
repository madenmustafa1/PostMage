import 'package:flutter/material.dart';
import 'package:mdntls/widgets/widget_util/calc_sized_box.dart';
import 'package:mdntls/widgets/text_and_button/simple_text.dart';
import '../../widgets/list/user_post_list_widget.dart';
import '../../widgets/appbar/basic_appbar.dart';
import '/util/color_util.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtil.GREY_PLATINUM,
      appBar: BasicAppBar(
        title: "Profile",
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Column(
                    children: [
                      const CalcSizedBox(calc: 35),
                      const CircleAvatar(
                        radius: 65.0,
                        backgroundImage: AssetImage('assets/test_images/2.jpg'),
                      ),
                      const CalcSizedBox(calc: 60),
                      Text(
                        'Erza Scarlet',
                        style: TextStyle(
                          color: ColorUtil.MAIN_COLOR,
                          fontSize: 20.0,
                        ),
                      ),
                      const CalcSizedBox(calc: 80),
                      const Text(
                        'S Class Mage',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15.0,
                        ),
                      )
                    ],
                  ),
                ),
                const CalcSizedBox(calc: 30),
                SimpleText(
                  text: "ACCESS SCAN CODE",
                  optionalTextSize: 40,
                ),
                const CalcSizedBox(calc: 50),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Divider(
                    color: ColorUtil.MAIN_COLOR,
                  ),
                ),
                UserPostListWidget(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


/*

Scaffold(
      appBar: BasicAppBar(
        title: "Profile",
      ),
      body: Container(),
    );

    */