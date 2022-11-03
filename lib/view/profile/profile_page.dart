import 'package:flutter/material.dart';
import '/view/profile/profile_viewmodel.dart';
import '/dependency_injection/setup.dart';
import '/enum/list_type.dart';
import '/widgets/widget_util/calc_sized_box.dart';
import '/widgets/text_and_button/simple_text.dart';
import '/widgets/list/user_post_list_widget.dart';
import '/widgets/appbar/basic_appbar.dart';
import '/util/color_util.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({
    Key? key,
  }) : super(key: key);

  final ProfileViewModel _profileViewModel = getIt<ProfileViewModel>();

  @override
  Widget build(BuildContext context) {
    getMyProfileInfo();
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
                    height: 12,
                    thickness: 1.8,
                  ),
                ),
                UserPostListWidget(listType: ListType.PROFILE),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void getMyProfileInfo() async {
    var result = await _profileViewModel.getMyProfileInfo();
  }
}
