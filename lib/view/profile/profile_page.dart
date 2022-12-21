// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import '../../util/constants.dart';
import '/model/profile/group_profile_info.dart';
import '/provider/profile/profile_page_provider.dart';
import '/view/profile/profile_viewmodel.dart';
import '/dependency_injection/setup.dart';
import '/enum/list_type.dart';
import '/widgets/widget_util/calc_sized_box.dart';
import '/widgets/text_and_button/simple_text.dart';
import '/widgets/list/user_post_list_widget.dart';
import '/util/color_util.dart';

class ProfilePage extends ConsumerWidget {
  ProfilePage({
    Key? key,
  }) : super(key: key);

  final ProfileViewModel _profileViewModel = getIt<ProfileViewModel>();
  UserProfileInfoModel? _userProfileModel;

  final Constants _constants = getIt<Constants>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _getMyProfileInfo(ref);
    return SingleChildScrollView(
      child: Stack(
        children: [
          Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    const CalcSizedBox(calc: 35),
                    CircleAvatar(
                      radius: 65.0,
                      backgroundImage: NetworkImage(
                        _userProfileModel?.profilePhotoUrl ?? "",
                      ),
                    ),
                    const CalcSizedBox(calc: 60),
                    Text(
                      _userProfileModel?.nameSurname ?? "",
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
              const CalcSizedBox(calc: 80),
              _userProfileModel != null
                  ? PrettyQr(
                      image: const AssetImage('assets/images/qr_code_icon.png'),
                      typeNumber: 3,
                      size: 100,
                      data: _userProfileModel!.userId ?? "",
                      errorCorrectLevel: QrErrorCorrectLevel.M,
                      roundEdges: true,
                    )
                  : Container(),
              const CalcSizedBox(calc: 30),
              SimpleText(
                text: _constants.profilePosts,
                optionalTextSize: 30,
              ),
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
    );
  }

  void _getMyProfileInfo(WidgetRef ref) async {
    _userProfileModel = ref.watch(getProfileInfoProvider);

    var model = await _profileViewModel.getMyProfileInfo();
    if (model.data != null && _userProfileModel == null) {
      _userProfileModel = model.data;
      ref.read(getProfileInfoProvider.notifier).update(model.data);
    }
  }

  void _updateProfilePhoto() {
    //TODO
    //profile/my-profile
  }
}
