// ignore_for_file: must_be_immutable

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mdntls/widgets/appbar_and_bottombar/drawer_menu.dart';
import 'package:mdntls/widgets/widget_util/show_toast.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import '../../util/constants.dart';
import '../../util/permission_util.dart';
import '../../widgets/image/show_list_image.dart';
import '/model/profile/group_profile_info.dart';
import '/provider/profile/profile_page_provider.dart';
import '/view/profile/profile_viewmodel.dart';
import '/dependency_injection/setup.dart';
import '/enum/list_type.dart';
import '/widgets/widget_util/calc_sized_box.dart';
import '/widgets/text_and_button/simple_text.dart';
import '/widgets/list/user_post_list_widget.dart';
import '/util/color_util.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePage createState() => _ProfilePage();
}

class _ProfilePage extends ConsumerState<ProfilePage> {
  final ProfileViewModel _profileViewModel = getIt<ProfileViewModel>();
  UserProfileInfoModel? _userProfileModel;
  final Constants _constants = getIt<Constants>();
  final PermissionUtil _permissionUtil = getIt<PermissionUtil>();
  final ImagePicker _picker = ImagePicker();
  Uint8List? selectedImageBytes;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback(
      (_) => _getMyProfileInfo(ref),
    );
  }

  @override
  Widget build(BuildContext context) {
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
                    GestureDetector(
                        onTap: () => _updateProfilePhoto(),
                        child: SizedBox(
                          height: 125,
                          width: 125,
                          child: showListImage(
                            context: context,
                            photoName: _userProfileModel?.profilePhotoUrl ?? "",
                            radius: 500,
                          ),
                        )),
                    const CalcSizedBox(calc: 60),
                    Text(
                      _userProfileModel?.nameSurname ?? "",
                      style: TextStyle(
                        color: ColorUtil.MAIN_COLOR,
                        fontSize: 20.0,
                      ),
                    ),
                    const CalcSizedBox(calc: 80),
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
    if (model.data != null) {
      _userProfileModel = model.data;
      ref.read(getProfileInfoProvider.notifier).update(model.data);
    }
  }

  void _updateProfilePhoto() async {
    var permissionResult = await _permissionUtil.permissonCameraHandler();
    bool permissionIsSuccess = true;
    permissionResult.forEach((key, PermissionStatus value) {
      if (value.isDenied) permissionIsSuccess = false;
    });

    if (permissionIsSuccess) {
      _takePhoto();
    }
  }

  XFile? pickedFile;
  Future<void> _takePhoto() async {
    try {
      pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        //maxWidth: maxWidth,
        //maxHeight: maxHeight,
        //imageQuality: quality,
      );

      if (pickedFile != null) {
        selectedImageBytes = await pickedFile!.readAsBytes();
        if (selectedImageBytes == null) return;
        var result = await _profileViewModel.putMyProfilePhoto(pickedFile);

        if (result) {
          ShowToast.successToast(constants.CHANGE_SUCCESS_PROFILE_PHOTO);
          return;
        } else {}
      }
      // ignore: empty_catches
    } catch (e) {}
    ShowToast.errorToast(constants.TR_GENERAL_ERROR);
    return;
  }
}
